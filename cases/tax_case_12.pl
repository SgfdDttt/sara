% Text
% Alice paid Bob for agricultural labor from Feb 1st, 2019 to November 19th, 2019, paying him $27371 in 2019. On November 25th, Bob died from a heart attack. On January 20th, 2020, Alice paid Charlie, Bob's surviving spouse, Bob's outstanding wages of $24500. In 2020, Alice's gross income was $372109. Alice receives a deduction of $25000 for donating goods to a food bank.

% Question
% How much tax does Alice have to pay in 2020? $118227

% Facts
:- [statutes/prolog/init].
service_(bob_works_for_alice).
agent_(bob_works_for_alice,bob).
patient_(bob_works_for_alice,alice).
start_(bob_works_for_alice,"2019-02-01").
end_(bob_works_for_alice,"2019-11-19").
purpose_(bob_works_for_alice,"agricultural labor").
payment_(alice_pays_bob).
agent_(alice_pays_bob,alice).
patient_(alice_pays_bob,bob).
purpose_(alice_pays_bob,bob_works_for_alice).
start_(alice_pays_bob,"2019-12-31").
amount_(alice_pays_bob,27371).
death_(bob_dies).
agent_(bob_dies,bob).
start_(bob_dies,"2019-11-25").
end_(bob_dies,"2019-11-25").
marriage_(bob_and_charlie).
agent_(bob_and_charlie,bob).
agent_(bob_and_charlie,charlie).
payment_(alice_pays_for_bob).
agent_(alice_pays_for_bob,alice).
patient_(alice_pays_for_bob,charlie).
start_(alice_pays_for_bob,"2020-01-20").
purpose_(alice_pays_for_bob,bob_works_for_alice).
amount_(alice_pays_for_bob,24500).
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2020-12-31").
amount_(alice_is_paid,372109).
deduction_(donation_to_food_bank).
agent_(donation_to_food_bank,alice).
amount_(donation_to_food_bank,25000).
start_(donation_to_food_bank,"2020-12-31").

% Test
:- tax(alice,2020,118227).
:- halt.
