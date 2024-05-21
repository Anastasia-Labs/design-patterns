#let image-background = image("Background-Carbon-Anastasia-Labs-01.jpg",height: 100%)
#set page(background: image-background)
#set text(15pt, font: "Barlow")

#v(3cm)

#align(center)[#box(width: 75%, image("Logo-Anastasia-Labs-V-Color02.png"))]

#v(1cm)

#set text(22pt, fill: white)

#align(center)[#strong[CLOSE-OUT REPORT]]\

#v(5cm)

#set text(13pt,fill: white)

#strong[Project Nr] 1000012 \ 
#strong[Streamlining Development:]
A User-Friendly Smart Contract Library \ 
for Plutarch and Aiken Design Patterns & Efficiency \
#strong[Date Started] Oct 8, 2023 \ 
#strong[Date Completed] \ 
#strong[Project manager]

#set text(fill: luma(0%))

#set page(
  background: none,
  header: [
  #place(right, dy: 12pt)[#box(image(height: 75%,"Logo-Anastasia-Labs-V-Color01.png"))]
  #line(length: 100%)
  ],
  header-ascent: 5%,
)
#show link: underline
#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}
#counter(page).update(0)
#v(100pt)
#outline(depth:2,indent: 1em)

#pagebreak()

#set page( 
footer: [
  #set text(11pt)
  #line(length: 100%)
  *Anastasia Labs* \
  Project Close-out Report
  #h(1fr)
  #counter(page).display("1/1",both: true)],
  footer-descent: 5%)
  
#v(100pt)
= List of KPIs
#v(50pt)
#box(height: 420pt,
 columns(2, gutter: 11pt)[
== Challenge KPIs
=== Performance Optimization
- Streamlined optimized #link("https://github.com/Anastasia-Labs/design-patterns/blob/main/enum-redeemers/ENUM-REDEEMERS.md")[mapping functions] to reduce complexity and cost in smart contracts
- Efficiently managed #link("https://github.com/Anastasia-Labs/design-patterns/blob/main/merkelized-validators/merkelized-validators.md")[script size and execution budgets] to reduce transaction fees
- #link("https://github.com/Anastasia-Labs/design-patterns/blob/main/stake-validator/STAKE-VALIDATOR.md")[Reduced ExUnits cost] compared to traditional checks
=== Security Enhancement
- Implemented measures against known exploits like #link("https://github.com/Anastasia-Labs/design-patterns/blob/main/stake-validator/STAKE-VALIDATOR.md")[double satisfaction]
- Ensured comprehensive validation by incorporating #link("https://github.com/Anastasia-Labs/design-patterns/blob/main/utxo-indexers/UTXO-INDEXERS.md")[UTxO indices] within the redeemer
=== Consistency 
- Predictable and optimized #link("https://github.com/Anastasia-Labs/design-patterns/blob/main/strict-and-checks/STRICT-AND-CHECKS.md")[compilation outcomes]
- Provided a normalized representation of #link("https://github.com/Anastasia-Labs/design-patterns/blob/main/validity-range-normalization/VALIDITY-RANGE-NORMALIZATION.md")[validity ranges]

== Project KPIs
=== Library Completeness 
- Inclusion of key design patterns for Plutarch and Aiken
=== Documentation Quality
- High-quality, detailed documentation for each smart contract library with detailed flow charts/images displaying solution architectures
=== Engagement
- Active participation in social networks, GitHub, and community events can be observed through various means like 
 ]
)

#pagebreak()

#v(60pt)
= Key achievements <key-achievements>
#v(3pt)
=== Development of Comprehensive Libraries
User-friendly libraries for Plutarch and Aiken, simplifying complex design patterns without sacrificing readability and circumventing repetitive boilerplate

Exemplary use of these libraries are found for 7 different validator scenarios in:\ 
\
- #link("https://github.com/Anastasia-Labs/aiken-design-patterns/tree/main/validators")[*For Aiken*]\ 
- #link("https://github.com/Anastasia-Labs/plutarch-design-patterns/blob/main/src/Plutarch/MerkelizedValidator.hs")[*For Plutarch*]

=== Engagement
Communication with the developer community (A presentation on design patterns was given in Buidlfest), which potentially will lead to adoption rates and valuable feedback

#v(10pt)
= Key learnings <key-learnings>
#v(15pt)
=== User Feedback
Actively incorporated feedback from developers/users to improve the libraries
=== Process Improvements
Improved the development process based on insights gained during the project
=== Best Practices
Further identified and documented best practices for smart contract development
#pagebreak()

#v(100pt)
= Next steps <next-steps>
#v(30pt)
=== Feature Enhancements
Further optimize and maintain existing libraries created for the developers. 

Additional design pattern libraries that streamline the implementation process for other existing smart contract languages. (Such as Scalus)

=== Expansion
Targeting a wider developer audience through increased outreach 

#v(70pt)
= Resources
#v(25pt)
#box(height: 100pt,
 columns(3, gutter: 1pt)[
== Project 
#link("https://github.com/Anastasia-Labs/design-patterns")[GitHub Repository]\
#link("https://projectcatalyst.io/funds/10/f10-development-and-infrastructure/anastasia-labs-streamlining-development-a-user-friendly-smart-contract-library-for-plutarch-and-aiken-design-patterns-and-efficiency")[Catalyst Proposal]
=== Aiken
#link("https://github.com/Anastasia-Labs/aiken-design-patterns")[Aiken - Design Patterns]\
#link("https://github.com/Anastasia-Labs/aiken-design-patterns/blob/main/assets/images/test_report.png")[Test Results] / #link("https://github.com/Anastasia-Labs/aiken-design-patterns/blob/main/assets/images/aiken-design-patterns.gif")[GIF]

=== Plutarch
#link("https://github.com/Anastasia-Labs/plutarch-design-patterns")[Plutarch - Design Patterns]\
#link("https://github.com/Anastasia-Labs/plutarch-design-patterns/blob/main/assets/images/test_report.png")[Test Results] / #link("https://github.com/Anastasia-Labs/plutarch-design-patterns/blob/main/assets/images/plutarch-design-patterns.gif")[GIF]])

#v(50pt)
#align(center)[== Close-out Video <link-other>
#link("linkhere")]



