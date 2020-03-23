% Text
% Alice has employed Bob from Jan 2nd, 2011 to Oct 10, 2019. On Oct 10, 2019 Bob was diagnosed as disabled and retired. Alice paid Bob $12980 because she had to terminate their contract due to Bob's disability. Alice had no plan established to provide for her employees' disabilities.

% Question
% Section 3306(b)(10)(B) applies to the payment of $12980 that Alice made in 2019. Contradiction

% Facts
:- [statutes/prolog/init].
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2011-01-02").
end_(alice_employer,"2019-10-10").
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
reason_(bob_retires,disability).
payment_(alice_pays).
agent_(alice_pays,alice).
patient_(alice_pays,bob).
start_(alice_pays,"2019-10-10").
purpose_(alice_pays,alice_lays_bob_off).
amount_(alice_pays,12980).

% Test
:- \+ s3306_b_10_B(alice,alice_pays,_).
:- halt.
