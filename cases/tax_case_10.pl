% Text
% Alice and Harold got married on Sep 3rd, 1992. Harold and Alice have a son, born Jan 25th, 2000. Harold died on Feb 28th, 2016. They had been living in the same house since 1993, maintained by Alice. Alice and her son continued doing so after Harold's death. Alice's gross income for the year 2017 is $236422. Alice has employed Bob, Cameron, Dan, Emily, Fred and George for agricultural labor from Sep 9th to Oct 1st 2017, and paid them $5012 each. Alice takes the standard deduction in 2017.

% Question
% How much tax does Alice have to pay in 2017? $68844

% Facts
:- [statutes/prolog/init].
marriage_(alice_and_harold_marriage).
agent_(alice_and_harold_marriage,alice).
agent_(alice_and_harold_marriage,harold).
start_(alice_and_harold_marriage,"1992-09-03").
son_(alice_and_harold_son).
agent_(alice_and_harold_son,unnamed_son).
patient_(alice_and_harold_son,alice).
patient_(alice_and_harold_son,harold).
start_(alice_and_harold_son,"2000-01-25").
death_(harold_dies).
agent_(harold_dies,harold).
start_(harold_dies,"2016-02-28").
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,home).
start_(alice_residence,"1993-01-01").
residence_(harold_residence).
agent_(harold_residence,harold).
patient_(harold_residence,home).
start_(harold_residence,"1993-01-01").
end_(harold_residence,"2016-02-28").
residence_(son_residence).
agent_(son_residence,unnamed_son).
patient_(son_residence,home).
start_(son_residence,"2000-01-25").
payment_(alice_maintains_home).
agent_(alice_maintains_home,alice).
amount_(alice_maintains_home,1).
purpose_(alice_maintains_home,home).
start_(alice_maintains_home,Day) :- between(1993,2093,Year), first_day_year(Year,Day).
income_(alice_income_2017).
agent_(alice_income_2017,alice).
amount_(alice_income_2017,236422).
start_(alice_income_2017,"2017-12-31").
alice_employer(Employee,Service_event_name,Payment_event_name) :-
    member(Employee,[bob,cameron,dan,emily,fred,george]),
    atom_concat('alice_employs_',Employee,Service_event_name),
    atom_concat('alice_pays_',Employee,Payment_event_name).
service_(Service_event) :- alice_employer(_,Service_event,_).
agent_(Service_event,Employee) :- alice_employer(Employee,Service_event,_).
patient_(Service_event,alice) :- alice_employer(_,Service_event,_).
start_(Service_event,"2017-09-09") :- alice_employer(_,Service_event,_).
end_(Service_event,"2017-10-01") :- alice_employer(_,Service_event,_).
payment_(Payment_event) :- alice_employer(_,_,Payment_event).
patient_(Payment_event,Employee) :- alice_employer(Employee,_,Payment_event).
agent_(Payment_event,alice) :- alice_employer(_,_,Payment_event).
start_(Payment_event,"2017-10-01") :- alice_employer(_,_,Payment_event).
amount_(Payment_event,5012) :- alice_employer(_,_,Payment_event).
purpose_(Payment_event,Service_event) :- alice_employer(_,Service_event,Payment_event).
purpose_(Service_event,"agricultural labor") :- alice_employer(_,Service_event,_).

% Test
:- tax(alice,2017,68844).
:- halt.
