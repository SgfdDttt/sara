% Text
% Alice's gross income for the year 2023 is $54775. In 2023, Bob, the son of her son Charlie, lives at her place, a house that she maintains. Bob has no income in 2023. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2023? $6449

% Facts
:- [statutes/prolog/init].
income_(alice_income_2023).
agent_(alice_income_2023,alice).
amount_(alice_income_2023,54775).
start_(alice_income_2023,"2023-12-31").
son_(bob_is_son).
agent_(bob_is_son,bob).
patient_(bob_is_son,charlie).
son_(charlie_is_son).
agent_(charlie_is_son,charlie).
patient_(charlie_is_son,alice).
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_house).
start_(alice_residence,"2023-01-01").
end_(alice_residence,"2023-12-31").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,alice_house).
start_(bob_residence,"2023-01-01").
end_(bob_residence,"2023-12-31").
payment_(alice_maintains_house).
agent_(alice_maintains_house,alice).
amount_(alice_maintains_house,1).
start_(alice_maintains_house,"2023-01-01").
purpose_(alice_maintains_house,alice_house).

% Test
:- tax(alice,2023,6449).
:- halt.
