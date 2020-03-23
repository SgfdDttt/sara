% Text
% Alice has a son, Bob, who in 2015 lives with her at the house she maintains as her home. Alice was paid $73200 in 2015 as an employee of Bertha's Mussels in Baltimore, Maryland, USA. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2015? $14296

% Facts
:- [statutes/prolog/init].
son_(bob_is_son).
agent_(bob_is_son,bob).
patient_(bob_is_son,alice).
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_house).
start_(alice_residence,"2015-01-01").
end_(alice_residence,"2015-12-31").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,alice_house).
start_(bob_residence,"2015-01-01").
end_(bob_residence,"2015-12-31").
payment_(alice_maintains_house).
agent_(alice_maintains_house,alice).
amount_(alice_maintains_house,1).
start_(alice_maintains_house,"2015-01-01").
purpose_(alice_maintains_house,alice_house).
service_(alice_employed).
patient_(alice_employed,"bertha's mussels").
agent_(alice_employed,alice).
start_(alice_employed,"2015-01-01").
end_(alice_employed,"2015-12-31").
location_(alice_employed,baltimore).
location_(alice_employed,maryland).
location_(alice_employed,usa).
payment_(alice_is_paid).
agent_(alice_is_paid,"bertha's mussels").
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2015-12-31").
purpose_(alice_is_paid,alice_employed).
amount_(alice_is_paid,73200).

% Test
:- tax(alice,2015,14296).
:- halt.
