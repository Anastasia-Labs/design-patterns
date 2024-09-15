import { Data } from "@lucid-evolution/plutus";
import {
  Blockfrost,
  Lucid,
  RedeemerBuilder,
  SpendingValidator
} from "@lucid-evolution/lucid";
import { toUnit } from "@lucid-evolution/utils";

const network = "Preview";

const lucid = await Lucid(
    new Blockfrost(
      `https://cardano-preview.blockfrost.io/api/v0`,
      CONFIG.API_KEY
    ),
    network
  );

const api = await window.cardano.nami.enable();
lucid.selectWallet.fromAPI(api);

const validatorA : SpendingValidator = {
      type: "PlutusV2",
      script: validatorACBOR,
    };
const contractAddress = validatorToAddress(network, validator);

//  policy id and asset name in Hex of the state token.
const stateToken = toUnit(STATE_TOKEN_CS, STATE_TOKEN_NAME) 
// Get the UTxO that contains the state token
const authUTxO = await lucid.utxoByUnit(stateTokenId);

const validatorARedeemer: RedeemerBuilder = {
  kind: "selected",
  // the function that constructs the redeemer using inputIndices, the list of indices
  // corresponding to the UTxOs defined as inputs below. 
  makeRedeemer: (inputIndices: bigint[]) => {
    return Data.to(inputIndices[0]);
  },
  // the inputs that are relevant to the construction of the redeemer in this case our
  // redeemer only cares about the index of the input that contains the auth token. 
  inputs: [authUTxO],
};

// Get the UTxO at validatorA that we want to spend
const [utxoAtValidatorA] = await lucid.utxosAt(contractAddress)

// Transaction that uses the redeemer
let tx = await lucid
  .newTx()
  .collectFrom([utxoAtValidatorA], validatorARedeemer)
  .collectFrom([authUTxO])
  .attach.SpendingValidator(validatorA)
  .complete();

// Sign the transaction
const signedTx = await tx.sign.withWallet().complete();
// Submit the transaction
const txHash = await signedTx.submit();
