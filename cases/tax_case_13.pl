% Text
% Alice's father, Bob, was paid $53249 in remuneration in 2017 for services performed for Johns Hopkins University. Alice was enrolled at Johns Hopkins University and attending classes from August 29, 2015 to May 30th, 2019. While attending classes at Johns Hopkins University, Alice lived at Bob's house, for which Bob furnished all costs. In 2017, Bob takes the standard deduction.

% Question
% How much tax does Bob have to pay in 2017? $8710

% Facts
:- [statutes/prolog/init].
father_(bob_and_alice).
agent_(bob_and_alice,bob).
patient_(bob_and_alice,alice).
payment_(bob_is_paid).
agent_(bob_is_paid,"johns hopkins university").
patient_(bob_is_paid,bob).
start_(bob_is_paid,"2017-12-31").
purpose_(bob_is_paid,bob_employed).
amount_(bob_is_paid,53249).
service_(bob_employed).
patient_(bob_employed,"johns hopkins university").
agent_(bob_employed,bob).
start_(bob_employed,"2017-01-01").
end_(bob_employed,"2017-12-31").
educational_institution_(hopkins_is_a_university).
agent_(hopkins_is_a_university,"johns hopkins university").
enrollment_(alice_goes_to_hopkins).
agent_(alice_goes_to_hopkins,alice).
patient_(alice_goes_to_hopkins,"johns hopkins university").
start_(alice_goes_to_hopkins,"2015-08-29").
end_(alice_goes_to_hopkins,"2019-05-30").
attending_classes_(alice_goes_to_class).
agent_(alice_goes_to_class,alice).
location_(alice_goes_to_class,"johns hopkins university").
start_(alice_goes_to_class,"2015-08-29").
end_(alice_goes_to_class,"2019-05-30").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,bob_house).
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,bob_house).
start_(alice_residence,"2015-08-29").
end_(alice_residence,"2019-05-30").
bob_household_maintenance(Year,Event,Start_day,End_day) :-
    between(2015,2019,Year), % avoid infinite forward loop
    atom_concat('bob_maintains_household_',Year,Event),
    (((Year==2015)->(Start_day="2015-08-29"));first_day_year(Year,Start_day)),
    (((Year==2019)->(End_day="2019-05-30"));last_day_year(Year,End_day)).
payment_(Event) :- bob_household_maintenance(_,Event,_,_).
agent_(Event,bob) :- bob_household_maintenance(_,Event,_,_).
amount_(Event,1) :- bob_household_maintenance(_,Event,_,_).
purpose_(Event,bob_house) :- bob_household_maintenance(_,Event,_,_).
start_(Event,Start_day) :- bob_household_maintenance(_,Event,Start_day,_).
end_(Event,End_day) :- bob_household_maintenance(_,Event,_,End_day).

% Test
:- tax(bob,2017,8710).
:- halt.
