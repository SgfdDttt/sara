% Text
% Alice married Bob on May 29th, 2008. Their son Charlie was born October 4th, 2004. Bob died October 22nd, 2016. Alice's gross income for the year 2016 was $113580. In 2017, Alice's gross income was $567192. In 2017, Alice and Charlie lived in a house maintained by Alice. That same year, Alice is allowed a deduction of $59850 for donating cash to a charity.

% Question
% How much tax does Alice have to pay in 2017? $180610

% Facts
:- [statutes/prolog/init].
marriage_(alice_marriage).
agent_(alice_marriage,alice).
agent_(alice_marriage,bob).
start_(alice_marriage,"2008-05-29").
son_(charlie_is_son).
agent_(charlie_is_son,charlie).
patient_(charlie_is_son,alice).
patient_(charlie_is_son,bob).
start_(charlie_is_son,"2004-10-04").
death_(bob_dies).
agent_(bob_dies,bob).
start_(bob_dies,"2016-10-22").
income_(alice_income_2016).
agent_(alice_income_2016,alice).
start_(alice_income_2016,"2016-12-31").
amount_(alice_income_2016,113580).
income_(alice_income_2017).
agent_(alice_income_2017,alice).
start_(alice_income_2017,"2017-12-31").
amount_(alice_income_2017,567192).
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_house).
start_(alice_residence,"2017-01-01").
end_(alice_residence,"2017-12-31").
residence_(charlie_residence).
agent_(charlie_residence,charlie).
patient_(charlie_residence,alice_house).
start_(charlie_residence,"2017-01-01").
end_(charlie_residence,"2017-12-31").
payment_(alice_maintains_house).
agent_(alice_maintains_house,alice).
amount_(alice_maintains_house,1).
start_(alice_maintains_house,"2017-01-01").
purpose_(alice_maintains_house,alice_house).
deduction_(deduction_for_donation).
agent_(deduction_for_donation,alice).
amount_(deduction_for_donation,59850).
start_(deduction_for_donation,"2017-12-31").

% Test
:- tax(alice,2017,180610).
:- halt.
