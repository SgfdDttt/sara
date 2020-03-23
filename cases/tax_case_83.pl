% Text
% In 2016, Alice's gross income was $567192.
% Alice has employed Bob, Cameron, Dan, Emily, Fred and George for agricultural labor on various occasions during the year 2016:
% - Jan 24: B, C, D, E and F
% - Feb 4: B, C and F
% - Mar 3: B, C, D, E and F
% - Mar 19: C, D, E, F and G
% - Apr 2: B, C, D, F and G
% - May 9: C, D, E, F and G
% - Oct 15: B, C, D, E and G
% - Oct 25: B, E, F and G
% - Nov 8: B, C, E, F and G
% - Nov 22: B, C, D, E and F
% - Dec 1: B, C, D, E and G
% - Dec 3: B, C, D, E and G
% On each occasion, Alice paid each of them $550. Alice takes the standard deduction in 2016.

% Question
% How much tax does Alice have to pay in 2016? $206073

% Facts
:- [statutes/prolog/init].
income_(alice_is_paid).
agent_(alice_is_paid,alice).
start_(alice_is_paid,"2016-12-31").
amount_(alice_is_paid,567192).
agricultural_service(Event,Employee,Day) :-
    member(Day, ["2016-01-24","2016-02-04","2016-03-03","2016-03-19","2016-04-02","2016-05-09","2016-10-15","2016-10-25","2016-11-08","2016-11-22","2016-12-01","2016-12-03"]),
    (
        (
            Day == "2016-01-24",
            member(Employee, [bob,cameron,dan,emily,fred])
        );
        (
            Day == "2016-02-04",
            member(Employee, [bob,cameron,fred])
        );
        (
            Day == "2016-03-03",
            member(Employee, [bob,cameron,dan,emily,fred])
        );
        (
            Day == "2016-03-19",
            member(Employee, [cameron,dan,emily,fred,george])
        );
        (
            Day == "2016-04-02",
            member(Employee, [bob,cameron,dan,fred,george])
        );
        (
            Day == "2016-05-09",
            member(Employee, [cameron,dan,emily,fred,george])
        );
        (
            Day == "2016-10-15",
            member(Employee, [bob,cameron,dan,emily,george])
        );
        (
            Day == "2016-10-25",
            member(Employee, [bob,emily,fred,george])
        );
        (
            Day == "2016-11-08",
            member(Employee, [bob,cameron,emily,fred,george])
        );
        (
            Day == "2016-11-22",
            member(Employee, [bob,cameron,dan,emily,fred])
        );
        (
            Day == "2016-12-01",
            member(Employee, [bob,cameron,dan,emily,george])
        );
        (
            Day == "2016-12-03",
            member(Employee, [bob,cameron,dan,emily,george])
        )
    ),
    atom_concat("alice_employer_",Day,Tmp),
    atom_concat(Tmp,"_",Tmp2),
    atom_concat(Tmp2,Employee,Event).
purpose_(Event,"agricultural labor") :-
    agricultural_service(Event,_,_).
service_(Event) :- agricultural_service(Event,_,_).
agent_(Event,Employee) :- agricultural_service(Event,Employee,_).
patient_(Event,alice) :- agricultural_service(Event,_,_).
start_(Event,Day) :- agricultural_service(Event,_,Day).
end_(Event,Day) :- agricultural_service(Event,_,Day).
payment_for_labor(Payment_event,Service_event,Employee,Day) :-
    agricultural_service(Service_event,Employee,Day),
    atom_concat(Service_event,"_payment",Payment_event).
payment_(Event) :- payment_for_labor(Event,_,_,_).
agent_(Event,alice) :- payment_for_labor(Event,_,_,_).
patient_(Event,Employee) :- payment_for_labor(Event,_,Employee,_).
start_(Event,Day) :- payment_for_labor(Event,_,_,Day).
amount_(Event,550) :- payment_for_labor(Event,_,_,_).
purpose_(Payment_event,Service_event) :-
    payment_for_labor(Payment_event,Service_event,_,_).

% Test
:- tax(alice,2016,206073).
:- halt.
