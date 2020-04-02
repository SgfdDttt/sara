%§7703. Determination of marital status
s7703(Individual,Spouse,Marriage,Divorce,Household,Child,Cost,Time_death,Year) :-
    (
        nonvar(Individual);
        nonvar(Spouse)
    ),
    Individual \== Spouse,
	s7703_a(Individual,Spouse,Marriage,Divorce,Time_death,Year),
	\+ s7703_b(Individual,Spouse,Household,Child,Cost,Year).

%(a) General rule
s7703_a(Individual,Spouse,Marriage,Divorce,Time_death,Year) :-
	s7703_a_1(Individual,Spouse,Marriage,Time_death,Year),
	\+ s7703_a_2(Individual,Spouse,Marriage,Divorce,Year).

%(1) the determination of whether an individual is married shall be made as of the close of his taxable year; except that if his spouse dies during his taxable year such determination shall be made as of the time of such death; and
s7703_a_1(Individual,Spouse,Marriage,Death_time,Year) :-
	% useful constants
	last_day_year(Year,Last_day_year),
	first_day_year(Year,First_day_year),
	Year1 is Year+1,
	first_day_year(Year1,First_day_next_year),
	% main body
	marriage_(Marriage),
	agent_(Marriage,Individual),
	agent_(Marriage,Spouse),
	Individual\==Spouse,
    (
        (
            \+ start_(Marriage,_),
            Start_marriage = First_day_year
        );
        (
            start_(Marriage,Start_marriage)
        )
    ),
    is_before(Start_marriage,Last_day_year),
	( % if spouse died during taxable year
		(
			death_(Death_spouse),
			agent_(Death_spouse,Spouse),
			start_(Death_spouse,Death_time),
			is_before(First_day_year,Death_time),
			is_before(Death_time,Last_day_year)
		) ->
		( % such determination shall be made as of the time of such death
			is_before(Start_marriage,Death_time),
			(
				( % marriage was still ongoing at death
					\+ end_(Marriage,_)
				);
				( % or ended with death
					end_(Marriage,End_time),
					is_before(Death_time,End_time)
				)
			)
		);
		( % otherwise, default behavior: check at end of year
			( % determining the end date of a marriage:
				( % if no end date,
					\+ end_(Marriage,_)
				) ->
				(
					( % if spouse died,
						death_(Spouse_dies),
						agent_(Spouse_dies,Spouse)
					) ->
					( % take death date as end time
						start_(Spouse_dies,End_time),
						is_before(First_day_next_year,End_time)
					);
					( % else marriage hasn't ended
						true
					)
				);
				( % else take end date
					end_(Marriage,End_time),
					is_before(First_day_next_year,End_time)
				)
			)
		)
	).

%(2) an individual legally separated from his spouse under a decree of divorce or of separate maintenance shall not be considered as married.
s7703_a_2(Individual,Spouse,Marriage,Divorce,Year) :-
    marriage_(Marriage),
    agent_(Marriage,Individual),
    agent_(Marriage,Spouse),
    Individual\==Spouse,
	legal_separation_(Divorce),
	patient_(Divorce,Marriage),
	(
		agent_(Divorce,"decree of divorce");
		agent_(Divorce,"decree of separate maintenance")
	),
	start_(Divorce,Divorce_time),
	last_day_year(Year,Last_day_year),
	is_before(Divorce_time,Last_day_year).

%(b) Certain married individuals living apart

%For purposes of those provisions of this title which refer to this subsection, if-
s7703_b(Individual,Spouse,Household,Child,Cost,Year) :-
	s7703_b_1(Individual,_,Household,_,Child,Year), 
	s7703_b_2(Individual,Household,Cost,Year),
	s7703_b_3(Individual,Spouse,Household,Year).


%(1) an individual who is married (within the meaning of subsection (a)) and who files a separate return maintains as his home a household which constitutes for more than one-half of the taxable year the principal place of abode of a child with respect to whom such individual is entitled to a deduction for the taxable year under section 151,
s7703_b_1(Individual,Home,Household,Principal_place_abode,Child,Year) :-
	first_day_year(Year,First_day_year),
	last_day_year(Year,Last_day_year),
	\+ (
		joint_return_(Joint_return),
		agent_(Joint_return,Individual),
		start_(Joint_return,First_day_year),
		end_(Joint_return,Last_day_year)
	),
	residence_(Individual_residence),
	agent_(Individual_residence,Individual),
	patient_(Individual_residence,Home),
    Household=Home,
	residence_(Child_lives_at_home),
	agent_(Child_lives_at_home,Child),
	patient_(Child_lives_at_home,Principal_place_abode),
    Principal_place_abode==Home,
	start_(Child_lives_at_home,Start_time),
    latest([Start_time,First_day_year],Start),
    (
        (
            \+ end_(Child_lives_at_home,_)
        );
        end_(Child_lives_at_home,End_time)
    ),
    earliest([End_time,Last_day_year],End),
	% now compute time stamp of end minus time stamp of beginning and compare with time stamps of 1/2 of the year 0.
    duration(Start,End,Duration),
    duration(First_day_year,Last_day_year,Year_duration),
    Half_year_duration is Year_duration rdiv 2,
	Duration >= Half_year_duration,
    s152_a_1(Child,Individual,Year).

%(2) such individual furnishes over one-half of the cost of maintaining such household during the taxable year, and
s7703_b_2(Individual,Household,Cost,Year) :-
    findall(
		Payment_amount,
		(
			payment_(Payment_event),
			residence_(Residence_event),
			agent_(Payment_event,Individual),
			patient_(Residence_event,Household),
			(
                purpose_(Payment_event,Residence_event);
                purpose_(Payment_event,Household)
            ),
			amount_(Payment_event,Payment_amount),
			start_(Payment_event,Payment_time), % assuming it's a single day
			split_string(Payment_time,"-","",[Year_payment,_,_]),
			atom_number(Year_payment,Year_payment_int),
			Year==Year_payment_int
		),
		Payments_by_individual
	),
	findall(
		Payment_amount,
		(
			payment_(Payment_event),
			residence_(Residence_event),
			patient_(Residence_event,Household),
			(
                purpose_(Payment_event,Residence_event);
                purpose_(Payment_event,Household)
            ),
			amount_(Payment_event,Payment_amount),
			start_(Payment_event,Payment_time), % assuming it's a single day
			split_string(Payment_time,"-","",[Year_payment,_,_]),
			atom_number(Year_payment,Year_payment_int),
			Year==Year_payment_int
		),
		Payments_all
	),
	sum_list(Payments_by_individual,Payment_by_individual),
	sum_list(Payments_all,Cost),
	Cost>0,
	Ratio is Payment_by_individual rdiv Cost,
	Ratio>=rational(0.5).

%(3) during the last 6 months of the taxable year, such individual's spouse is not a member of such household,
s7703_b_3_is_member_of_household(Spouse,Household,Day) :-
    residence_(Spouse_lives_in_household),
    agent_(Spouse_lives_in_household,Spouse),
	patient_(Spouse_lives_in_household,Household),
    start_(Spouse_lives_in_household,Time_start),
    is_before(Time_start,Day),
	(
		(
			\+ end_(Spouse_lives_in_household,_)
		);
		(
			end_(Spouse_lives_in_household,Time_end),
			is_before(Day,Time_end)
		)
	).
    
s7703_b_3(Individual,Spouse,Household,Year) :-
    s7703_a(Individual,Spouse,_,_,_,Year),
    findall(
        Day_offset,
        (
            between(2,185,Day_offset),
            date_time_stamp(date(Year,7,Day_offset,0,0,0,0,-,-), Stamp),
            format_time(atom(Day), "%Y-%m-%d", Stamp),
            s7703_b_3_is_member_of_household(Spouse,Household,Day)
        ),
        Days_membership
    ),
    length(Days_membership,Num_days),
    Num_days==0.

%such individual shall not be considered as married.
