% Text
% In 2018, Alice was paid $3200. Alice and Bob have been married since Feb 3rd, 2017. Alice and Bob file separate returns and each take their standard deduction. Bob had no income in 2018. Alice has been blind since March 20, 2016. Alice was enrolled at Johns Hopkins University and attending classes from August 29, 2015 to May 30th, 2019.

% Question
% How much tax does Alice have to pay in 2018? $0

% Facts
:- [statutes/prolog/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2018-12-31").
amount_(alice_is_paid,3200).
marriage_(alice_and_bob).
agent_(alice_and_bob,alice).
agent_(alice_and_bob,bob).
start_(alice_and_bob,"2017-02-03").
blindness_(alice_is_blind).
agent_(alice_is_blind,alice).
start_(alice_is_blind,"2016-03-20").
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

% Test
:- tax(alice,2018,0).
:- halt.
