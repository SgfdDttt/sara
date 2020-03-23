% Text
% Alice was paid $1200 in 2019 for services performed in jail. Alice was committed to jail from January 24, 2015 to May 5th, 2019. From May 5th 2019 to Dec 31st 2019, Alice was paid $5320 in remuneration. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2019? $0

% Facts
:- [statutes/prolog/init].
service_(alice_employed_in_jail).
patient_(alice_employed_in_jail,jail).
agent_(alice_employed_in_jail,alice).
start_(alice_employed_in_jail,"2019-01-01").
end_(alice_employed_in_jail,"2019-05-05").
payment_(alice_is_paid).
agent_(alice_is_paid,jail).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2019-05-05").
purpose_(alice_is_paid,alice_employed_in_jail).
amount_(alice_is_paid,1200).
penal_institution_(jail_is_a_penal_institution).
agent_(jail_is_a_penal_institution,jail).
incarceration_(alice_goes_to_jail).
agent_(alice_goes_to_jail,alice).
patient_(alice_goes_to_jail,jail).
start_(alice_goes_to_jail,"2015-01-24").
end_(alice_goes_to_jail,"2019-05-05").
payment_(alice_is_paid_out_of_jail).
patient_(alice_is_paid_out_of_jail,alice).
amount_(alice_is_paid_out_of_jail,5320).
start_(alice_is_paid_out_of_jail,"2019-12-31").

% Test
:- tax(alice,2019,0).
:- halt.
