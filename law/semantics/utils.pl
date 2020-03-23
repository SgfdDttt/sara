% time
day_to_stamp(Day, Stamp) :- % convert day in YYYY-MM-DD format to time stamp
	split_string(Day,"-","",[YS,MS,DS]),
	atom_number(YS,YI),
	atom_number(MS,MI),
	atom_number(DS,DI),
	DI1 is DI+1,
	date_time_stamp(date(YI,MI,DI1,0,0,0,0,-,-), Stamp).

is_before(Day1,Day2) :- % Is true if Day2 occurs after Day1. Arguments are input as strings in format YYYY-MM-DD.
    nonvar(Day1), nonvar(Day2),
	day_to_stamp(Day1,Stamp1),
	day_to_stamp(Day2,Stamp2),
    Stamp1=<Stamp2.

last_day_year(Year,Day) :-
	atom_string(Year,Year_s),
	string_concat(Year_s,"-12-31",Day).

first_day_year(Year,Day) :-
	atom_string(Year,Year_s),
	string_concat(Year_s,"-01-01",Day).

% out of days in format YYYY-MM-DD, extract latest day
latest([],_). % just leave the output unbound

latest([Day|Days],Output) :- 
    (
        nonvar(Day),
        latest(Days,Day,Output)
    );
    (
        var(Day),
        latest(Days,Output)
    ).

latest([],Output,Output).

latest([Day|Days],Latest,Output) :-
    (
        nonvar(Day),
        (
            (
                is_before(Day,Latest),
                latest(Days,Latest,Output)
            );
            (
                \+ is_before(Day,Latest),
                latest(Days,Day,Output)
            )
        )
    );
    (
        var(Day),
        latest(Days,Latest,Output)
    ).

% out of days in format YYYY-MM-DD, extract earliest date
earliest([],_). % just leave the output unbound

earliest([Day|Days],Output) :- 
    (
        nonvar(Day),
        earliest(Days,Day,Output)
    );
    (
        var(Day),
        earliest(Days,Output)
    ).

earliest([],Output,Output).

earliest([Day|Days],Earliest,Output) :-
    (
        nonvar(Day),
        (
            (
                is_before(Earliest,Day),
                earliest(Days,Earliest,Output)
            );
            (
                \+ is_before(Earliest,Day),
                earliest(Days,Day,Output)
            )
        )
    );
    (
        var(Day),
        earliest(Days,Earliest,Output)
    ).

duration(Day1,Day2,Duration) :- % duration in arbitrary units for days in YYYY-MM-DD format
	day_to_stamp(Day1, Stamp1),
	day_to_stamp(Day2, Stamp2),
	Duration is Stamp2-Stamp1.

% kinship
is_child_of(X,Y,Day_start,Day_end) :- % X is the child of Y from Day_start to Day_end if...
	( % what kind of relationship exists between X and Y
		( % X is child of Y, or
			(
                son_(Relationship);
                daughter_(Relationship)
			),
			agent_(Relationship,X),
			patient_(Relationship,Y)
		);
		( % Y is parent of X
			(
				father_(Relationship);
                mother_(Relationship)
			),
			agent_(Relationship,Y),
			patient_(Relationship,X)
		)
	),
	(
        (
            \+ start_(Relationship,_)
        );
        start_(Relationship,Day_start)
    ),
	(
		( % if no end to Relationship then it's still ongoing
			\+ end_(Relationship,_)
		);
        end_(Relationship,Day_end)
	).

is_sibling_of(X,Y,Day_start,Day_end) :- % X is the sibling of Y on from Day_start to Day_end if...
	( % there is a brother or sister relationship
		brother_(Relationship);
		sister_(Relationship)
	),
	( % X is somehow involved in it
		agent_(Relationship,X);
		patient_(Relationship,X)
	),
	( % and so is Y
		agent_(Relationship,Y);
		patient_(Relationship,Y)
	),
	(
        (
            \+ start_(Relationship,_)
        );
        start_(Relationship,Day_start)
    ),
	(
		( % if no end to Relationship then it's still ongoing
			\+ end_(Relationship,_)
		);
        end_(Relationship,Day_end)
	).

is_descendent_of(X,Y,Day_start,Day_end) :- % X is a descendent of Y if
	( % as a base case, X is a descendent of Y if X is a child of Y
		is_child_of(X,Y,Day_start,Day_end)
	);
	( % else
		is_child_of(Z,Y,_,_), % Z is a child of Y and
		is_descendent_of(X,Z,Day_start,Day_end) % X is a descendent of Z
	).

is_stepsibling_of(X,Y,Day_start,Day_end) :- % X is stepsibling of Y if
	is_child_of(Y,ParentY,Day_start_x,Day_end_x), % one of the parents of Y
	is_child_of(X,ParentX,Day_start_y,Day_end_y), % and one of the parents of X
	marriage_(Marriage), % got married
	agent_(Marriage,ParentY),
	agent_(Marriage,ParentX),
    (
        (
            \+ start_(Marriage,_)
        );
        start_(Marriage,Start_time)
    ),
    latest([Day_start_x,Day_start_y,Start_time], Day_start),
	(
		(
			\+ end_(Marriage,_)
		);
        end_(Marriage,End_time)
	),
    earliest([Day_end_x,Day_end_y,End_time],Day_end).

is_sibling_in_law_of(X,Y,Day_start,Day_end) :- % symmetry of relationship
    is_sibling_in_law_of_aux(X,Y,Day_start,Day_end);
    is_sibling_in_law_of_aux(Y,X,Day_start,Day_end).

is_sibling_in_law_of_aux(X,Y,Day_start,Day_end) :- % X is sibling in law of Y if
	is_sibling_of(Y,SiblingY,Day_start_y,Day_end_y), % one of Y's siblings
	marriage_(Marriage), % and X got married
	agent_(Marriage,SiblingY),
	agent_(Marriage,X),
    (
        (
            \+ start_(Marriage,_)
        );
        start_(Marriage,Start_time)
    ),
    latest([Start_time,Day_start_y],Day_start),
	(
		(
			\+ end_(Marriage,_)
		);
        end_(Marriage,End_time)
	),
    earliest([End_time,Day_end_y],Day_end).

is_child_in_law_of(X,Y,Day_start,Day_end) :- % X is child in law of Y if
	is_child_of(ChildY,Y,Day_start_y,Day_end_y), % one of the children of Y
	marriage_(Marriage), % got married with X
	agent_(Marriage,ChildY),
	agent_(Marriage,X),
    (
        (
            \+ start_(Marriage,_)
        );
        start_(Marriage,Start_time)
    ),
    latest([Start_time,Day_start_y],Day_start),
	(
		(
			\+ end_(Marriage,_)
		);
        end_(Marriage,End_time)
	),
    earliest([End_time,Day_end_y],Day_end).

is_parent_in_law_of(X,Y,Day_start,Day_end) :- % X is parent in law of Y if
	is_child_of(Y,ParentY,Day_start_y,Day_end_y), % one of the parents of Y
	marriage_(Marriage), % got married with X
	agent_(Marriage,ParentY),
	agent_(Marriage,X),
    (
        (
            \+ start_(Marriage,_)
        );
        start_(Marriage,Start_time)
    ),
    latest([Start_time,Day_start_y],Day_start),
	(
		(
			\+ end_(Marriage,_)
		);
        end_(Marriage,End_time)
	),
    earliest([End_time,Day_end_y],Day_end).

is_stepparent_of(X,Y,Day_start,Day_end) :- % X is parent in law of Y if
	is_child_of(Y,ParentY,Day_start_y,Day_end_y), % one of the parents of Y
	marriage_(Marriage), % got married with X
	agent_(Marriage,ParentY),
	agent_(Marriage,X),
	start_(Marriage,Start_time), % and their marriage holds on Day
    latest([Start_time,Day_start_y],Day_start),
	(
		(
			\+ end_(Marriage,_)
		);
        end_(Marriage,End_time)
	),
    earliest([End_time,Day_end_y],Day_end).

% aggregation of income
gross_income(Person,Year,Gross_income) :-
	first_day_year(Year,First_day_year),
    last_day_year(Year,Last_day_year),
    (
        ( % if the individual is filing a joint return with his spouse, sum both incomes
            s7703(Person,Spouse,_,_,_,_,_,Year),
            joint_return_(Joint_return),
            agent_(Joint_return,Person),
            agent_(Joint_return,Spouse),
            start_(Joint_return,First_day_year),
            end_(Joint_return,Last_day_year),
            gross_income_individual(Person,Year,Income_individual),
            gross_income_individual(Spouse,Year,Income_spouse),
            Gross_income is Income_individual+Income_spouse
        );
        ( % otherwise, it's just the individual's income
            \+ (
                s7703(Person,Spouse,_,_,_,_,_,Year),
                joint_return_(Joint_return),
                agent_(Joint_return,Person),
                agent_(Joint_return,Spouse),
                start_(Joint_return,First_day_year),
                end_(Joint_return,Last_day_year)
            ),
            gross_income_individual(Person,Year,Gross_income)
        )
    ).

gross_income_individual(Person,Year,Gross_income) :-
    first_day_year(Year,First_day_year),
    last_day_year(Year,Last_day_year),
    findall(
        Amount,
        (
            income_(Income_event),
            agent_(Income_event,Person),
            amount_(Income_event,Amount),
            start_(Income_event,Start_time),
            is_before(First_day_year,Start_time),
            is_before(Start_time,Last_day_year)
        ),
        Income_amounts
    ),
    findall(
        Amount,
        (
            payment_(Payment_event),
            patient_(Payment_event,Person),
            amount_(Payment_event,Amount),
            start_(Payment_event,Start_time),
            is_before(First_day_year,Start_time),
            is_before(Start_time,Last_day_year)
        ),
        Payment_amounts
    ),
    sum_list(Income_amounts,Income),
    sum_list(Payment_amounts,Payment),
    Gross_income is Income+Payment.

% compute tax owed by a Person for a given taxable year
tax(Person,Year,Tax_amount) :-
    (
        s1(Person,Year,Income_tax);
        (
            \+ s1(Person,Year,_),
            Income_tax is 0
        )
    ),
    (
        s3301(Person,Year,_,Employment_tax);
        (
            \+ s3301(Person,Year,_,_),
            Employment_tax is 0
        )
    ),
    Tax_amount is Income_tax+Employment_tax.
