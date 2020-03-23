% Text
% Alice employed Bob from Jan 2nd, 2011 to Oct 10, 2019, paying him $1513 in 2019. On Oct 10, 2019 Bob was diagnosed as disabled and retired. Alice paid Bob $298 because she had to terminate their contract due to Bob's disability. In 2019, Alice's gross income was $567192. In 2019, Alice lived together with Charlie, her father, in a house that she maintains. Charlie had no income in 2019. Alice takes the standard deduction in 2019.

% Question
% How much tax does Alice have to pay in 2019? $196056

% Facts
:- [statutes/prolog/init].
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2011-01-02").
end_(alice_employer,"2019-10-10").
payment_(alice_pays_bob).
agent_(alice_pays_bob,alice).
patient_(alice_pays_bob,bob).
amount_(alice_pays_bob,1513).
purpose_(alice_pays_bob,alice_employer).
start_(alice_pays_bob,"2019-12-31").
disability_(bob_is_disabled).
agent_(bob_is_disabled,bob).
start_(bob_is_disabled,"2019-10-10").
termination_(alice_lays_bob_off).
agent_(alice_lays_bob_off,alice).
patient_(alice_lays_bob_off,alice_employer).
reason_(alice_lays_bob_off,bob_is_disabled).
retirement_(bob_retires).
agent_(bob_retires,bob).
start_(bob_retires,"2019-10-10").
reason_(bob_retires,"disability").
payment_(alice_pays).
agent_(alice_pays,alice).
patient_(alice_pays,bob).
start_(alice_pays,"2019-10-10").
purpose_(alice_pays,alice_lays_bob_off).
amount_(alice_pays,298).
income_(alice_income).
agent_(alice_income,alice).
start_(alice_income,"2019-12-31").
amount_(alice_income,567192).
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_house).
start_(alice_residence,"2019-01-01").
end_(alice_residence,"2019-12-31").
residence_(charlie_residence).
agent_(charlie_residence,charlie).
patient_(charlie_residence,alice_house).
start_(charlie_residence,"2019-01-01").
end_(charlie_residence,"2019-12-31").
father_(charlie_father_of_alice).
agent_(charlie_father_of_alice,charlie).
patient_(charlie_father_of_alice,alice).
payment_(alice_maintains_house).
agent_(alice_maintains_house,alice).
amount_(alice_maintains_house,1).
start_(alice_maintains_house,"2019-01-01").
purpose_(alice_maintains_house,alice_house).

% Test
:- tax(alice,2019,196056).
:- halt.
