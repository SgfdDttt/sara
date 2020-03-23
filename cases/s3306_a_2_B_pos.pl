% Text
% Alice has employed Bob, Cameron, Dan, Emily, Fred and George for agricultural labor on various occasions during the year 2017:
% - Jan 24: B, C, D, E and F
% - Feb 4: B, C, D, E and F
% - Mar 3: B, C, D, E and F
% - Mar 19: C, D, E, F and G
% - Apr 2: B, C, D, F and G
% - May 9: C, D, E, F and G
% - Oct 15: B, C, D, E and G
% - Oct 25: B, C, D, E, F and G
% - Nov 8: B, C, E, F and G
% - Nov 22: B, C, D, E and F
% - Dec 1: B, C, D, E and G
% - Dec 3: B, C, D, E and G

% Question
% Section 3306(a)(2)(B) applies to Alice for the year 2017. Entailment

% Facts
:- discontiguous s3306_c/6.
:- [law/semantics/init].
s3306_c(Service_event,alice,Employee,_,Day,_) :-
    member(Day, ["2017-01-24","2017-02-04","2017-03-03","2017-03-19","2017-04-02","2017-05-09","2017-10-15","2017-10-25","2017-11-08","2017-11-22","2017-12-01","2017-12-03"]),
    (
        (
            Day == "2017-01-24",
            member(Employee, [bob,cameron,dan,emily,fred])
        );
        (
            Day == "2017-02-04",
            member(Employee, [bob,cameron,dan,emily,fred])
        );
        (
            Day == "2017-03-03",
            member(Employee, [bob,cameron,dan,emily,fred])
        );
        (
            Day == "2017-03-19",
            member(Employee, [cameron,dan,emily,fred,george])
        );
        (
            Day == "2017-04-02",
            member(Employee, [bob,cameron,dan,fred,george])
        );
        (
            Day == "2017-05-09",
            member(Employee, [cameron,dan,emily,fred,george])
        );
        (
            Day == "2017-10-15",
            member(Employee, [bob,cameron,dan,emily,george])
        );
        (
            Day == "2017-10-25",
            member(Employee, [bob,cameron,dan,emily,fred,george])
        );
        (
            Day == "2017-11-08",
            member(Employee, [bob,cameron,emily,fred,george])
        );
        (
            Day == "2017-11-22",
            member(Employee, [bob,cameron,dan,emily,fred])
        );
        (
            Day == "2017-12-01",
            member(Employee, [bob,cameron,dan,emily,george])
        );
        (
            Day == "2017-12-03",
            member(Employee, [bob,cameron,dan,emily,george])
        )
    ),
    atom_concat("alice_employer_",Day,Service_event).
purpose_(_,"agricultural labor"). % all that's mentioned here is agricultural labor

% Test
:- s3306_a_2_B(alice,2017).
:- halt.
