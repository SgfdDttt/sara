%§3306. Definitions

%(a) Employer
s3306_a(Person,Year,Total_wages) :-
	s3306_a_1(Person,Year,Total_wages);
	s3306_a_2(Person,Year,Total_wages);
	s3306_a_3(Person,Year,Total_wages).

%(1) In general

%The term "employer" means, with respect to any calendar year, any person who-
s3306_a_1(Person,Year,Total_wages) :-
	s3306_a_1_A(Person,Year,Total_wages);
	s3306_a_1_B(Person,Year).

%(A) during any calendar quarter in the calendar year or the preceding calendar year paid wages of $1,500 or more, or
s3306_a_1_is_wages(Person, Year, Remuneration, Wages) :-
    s3306_b(Wages,Remuneration,Service,Person,_,_,_,_,_,_,_),
	start_(Remuneration,Time),
    last_day_year(Year,Last_day_year),
    is_before(Time,Last_day_year),
    first_day_year(Year,First_day_year),
    is_before(First_day_year,Time),
    \+ purpose_(Service, "agricultural labor"),
	\+ purpose_(Service, "domestic service").

s3306_a_1_A(Person,Year,Total_wages) :-
	findall(
		Amount,
		(
			s3306_a_1_is_wages(Person, Year, Remuneration, Amount);
			(
				Pyear is Year-1,
				s3306_a_1_is_wages(Person, Pyear, Remuneration, Amount)
			)
		),
		Wages
	),
	sum_list(Wages,Total_wages),
	Total_wages>=1500.

%(B) on each of some 10 days during the calendar year or during the preceding calendar year, each day being in a different calendar week, employed at least one individual in employment for some portion of the day.
s3306_a_1_is_day_of_employment(Person, Day) :-
	s3306_c(Service,Person,_,_,Day,_),
    \+ purpose_(Service,"agricultural labor"),
    \+ purpose_(Service,"domestic service"),
    \+ type_(Service,"agricultural labor"),
    \+ type_(Service,"domestic service").

s3306_a_1_B(Person,Year) :-
    last_day_year(Year,Last_day_year),
    Year1 is Year-1,
    first_day_year(Year1,First_day_year1),
	findall(
		Stamp,
		(
			s3306_a_1_is_day_of_employment(Person,Day),
            is_before(First_day_year1,Day),
            is_before(Day,Last_day_year),
            day_to_stamp(Day,Stamp)
		),
		Emp_days
	),
    list_to_set(Emp_days,Emp_days_set),
	length(Emp_days_set,Num_days),
	Num_days>=10,
    findall(
		Week,
		(
			member(Stamp,Emp_days),
			format_time(atom(Week), "%W", Stamp)
		),
		Weeks
	),
	list_to_set(Weeks,Weeks_set),
	length(Weeks_set,Num_weeks),
	Num_weeks>=10.

%For purposes of this paragraph, there shall not be taken into account any wages paid to, or employment of, an employee performing domestic services referred to in paragraph (3).

%(2) Agricultural labor

%In the case of agricultural labor, the term "employer" means, with respect to any calendar year, any person who-
s3306_a_2(Person,Year,Total_wages) :-
	s3306_a_2_A(Person,Year,Total_wages);
	s3306_a_2_B(Person,Year).

%(A) during any calendar quarter in the calendar year or the preceding calendar year paid wages of $20,000 or more for agricultural labor, or
s3306_a_2_is_wages(Person, Year, Remuneration, Wages) :- 
    s3306_b(Wages,Remuneration,Service,Person,_,_,_,_,_,_,_),
    start_(Remuneration,Time),
    last_day_year(Year,Last_day_year),
    is_before(Time,Last_day_year),
    first_day_year(Year,First_day_year),
    is_before(First_day_year,Time),
    purpose_(Service, "agricultural labor").

s3306_a_2_A(Person,Year,Total_wages) :-
	findall(
		Amount,
		(
			s3306_a_2_is_wages(Person, Year, Epay, Amount);
			(
				Pyear is Year-1,
				s3306_a_2_is_wages(Person, Pyear, Epay, Amount)
			)
		),
		Wageslist
	),
	sum_list(Wageslist,Total_wages),
	Total_wages>=20000.

%(B) on each of some 10 days during the calendar year or during the preceding calendar year, each day being in a different calendar week, employed at least 5 individuals in employment in agricultural labor for some portion of the day.
s3306_a_2_is_day_of_employment(Person, Day) :-
	findall(
        Employee,
        (
            s3306_c(Service,Person,Employee,_,Day,_),
            (
                purpose_(Service,"agricultural labor");
                type_(Service,"agricultural labor")
            )
        ),
        Employees
    ),
    list_to_set(Employees,Employees_no_dup),
	length(Employees_no_dup,Num_employees),
	Num_employees>=5.

s3306_a_2_B(Person,Year) :-
    last_day_year(Year,Last_day_year),
    Year1 is Year-1,
    first_day_year(Year1,First_day_year1),
	findall(
		Stamp,
		(
            s3306_c(_,Person,_,_,Day,_), % narrow down the list of days
			s3306_a_2_is_day_of_employment(Person,Day), % check that 5+ people were employed
            is_before(First_day_year1,Day),
            is_before(Day,Last_day_year),
            day_to_stamp(Day,Stamp)
		),
		Emp_days
	),
	list_to_set(Emp_days,Emp_days_set),
	length(Emp_days_set,Num_days),
	Num_days>=10,
    findall(
		Week,
		(
			member(Stamp,Emp_days),
			format_time(atom(Week), "%W", Stamp)
		),
		Weeks
	),
    list_to_set(Weeks,Weeks_set),
	length(Weeks_set,Num_weeks),
	Num_weeks>=10.

%(3) Domestic service

%In the case of domestic service in a private home, local college club, or local chapter of a college fraternity or sorority, the term "employer" means, with respect to any calendar year, any person who during any calendar quarter in the calendar year or the preceding calendar year paid wages in cash of $1,000 or more for such service.
s3306_a_3_is_wages(Person, Year, Remuneration, Wages) :-
    s3306_b(Wages,Remuneration,Service,Person,_,_,_,_,_,_,_),
    start_(Remuneration,Time),
    last_day_year(Year,Last_day_year),
    is_before(Time,Last_day_year),
    first_day_year(Year,First_day_year),
    is_before(First_day_year,Time),
	(
		(
			\+ means_(Remuneration,_)
		);
		(
			means_(Remuneration,"cash")
		)
	),
	purpose_(Service, "domestic service").

s3306_a_3(Person,Year,Total_wages) :-
	findall(
		Amount,
        (
			s3306_a_3_is_wages(Person, Year, Epay, Amount);
			(
				Pyear is Year-1,
				s3306_a_3_is_wages(Person, Pyear, Epay, Amount)
			)
		),
		Wages
	),
	sum_list(Wages,Total_wages),
	Total_wages>=1000.

%(4) Special rule

%A person treated as an employer under paragraph (3) shall not be treated as an employer with respect to wages paid for any service other than domestic service referred to in paragraph (3) unless such person is treated as an employer under paragraph (1) or (2) with respect to such other service.
% This will be satisfied automatically here since all 3 types of employer are kept separate.
s3306_a_4(). % always true.

%(b) Wages

%For purposes of this chapter, the term "wages" means all remuneration for employment, including the cash value of all remuneration (including benefits) paid in any medium other than cash; except that such term shall not include-
s3306_b(Wages,Remuneration,Service,Payer,Payee,Payee_dependent,Plan,Termination,Reason,Employer,Employee) :-
	payment_(Remuneration),
    agent_(Remuneration,Payer),
    (
        (
            patient_(Remuneration,Payee),
            \+ plan_(Payee)
        );
        (
            patient_(Remuneration,Plan),
            plan_(Plan),
            beneficiary_(Plan,Payee)
        )
    ),
	service_(Service),
    agent_(Service,Employee),
    patient_(Service,Employer),
	purpose_(Remuneration,Service),
    end_(Service,End_service),
	split_string(End_service,"-","",[Year_s,_,_]),
	atom_number(Year_s,Year),
	s3306_c(Service,_,_,_,_,Year),
	amount_(Remuneration,Wages_before),
    s3306_b_1(Wages_before,Wages),
	\+ s3306_b_2(Remuneration,Service,Payer,Payee,Payee_dependent,Plan),
    \+ s3306_b_7(Remuneration,Service,Payer,Payee),
	\+ s3306_b_10(Remuneration,Service,Termination,Reason,Payer,Payee,Payee_dependent,Plan),
	\+ s3306_b_11(Remuneration,Service),
    \+ s3306_b_15(Remuneration,Employer,Payee,Employee).

%(1) that part of the remuneration which, after remuneration (other than remuneration referred to in the succeeding paragraphs of this subsection) equal to $7,000 with respect to employment has been paid to an individual by an employer during any calendar year, is paid to such individual by such employer during such calendar year;
s3306_b_1(Amount_before,Amount_after) :-
    Amount_after is min(7000,Amount_before).

%(2) the amount of any payment (including any amount paid by an employer for insurance or annuities, or into a fund, to provide for any such payment) made to, or on behalf of, an employee or any of his dependents under a plan or system established by an employer which makes provision for his employees generally (or for his employees generally and their dependents) or for a class or classes of his employees (or for a class or classes of his employees and their dependents), on account of-
s3306_b_2(Payment,Service,Employer,Employee,Employee_dependent,Plan) :-
	s3306_c(Service,Employer,Employee,_,_,_),
	payment_(Payment),
	agent_(Payment,Employer),
	plan_(Plan), % existence of the plan
	beneficiary_(Plan,Payee),
	(
		Employee==Payee;
		(
			Payee==Employee_dependent,
			s152(Employee_dependent,Employee,_)
		)
	),
	(
		s3306_b_2_A(Plan);
		s3306_b_2_C(Plan)
	),
	(   % payment into a fund
		patient_(Payment,Plan);
		% payment using the fund
		(
			means_(Payment,Plan),
			patient_(Payment,Payee)
		)
	).

%(A) sickness or accident disability, or
s3306_b_2_A(Plan) :-
	purpose_(Plan,"make provisions for employees in case of sickness");
	purpose_(Plan,"make provisions for employees in case of accident disability").

%(C) death;
s3306_b_2_C(Plan) :-
	purpose_(Plan,"make provisions for employees in case of death").

%(7) remuneration paid in any medium other than cash to an employee for service not in the course of the employer's trade or business;
s3306_b_7(Remuneration,Service,Employer,Employee) :-
	s3306_c(Service,Employer,Employee,_,_,_),
	means_(Remuneration,Medium),
	Medium\=="cash",
    business_(Employers_business),
	agent_(Employers_business,Employer),
	type_(Employers_business,Type_business),
    type_(Service,Type_service),
	Type_business \== Type_service.

%(10) any payment or series of payments by an employer to an employee or any of his dependents which is paid-
s3306_b_10(Payment,Service,Termination,Reason,Employer,Employee,Employee_dependent,Plan) :-
	s3306_c(Service,Employer,Employee,_,_,_),
    start_(Payment,Remuneration_day),
	split_string(Remuneration_day,"-","",[Year,_,_]),
	atom_number(Year,Year_int),
	agent_(Payment,Employer),
	patient_(Payment,Payee),
	(
		Employee==Payee;
		(
			s152(Employee,Employee_dependent,Year_int),
			Employee_dependent==Payee
		)
	),
	s3306_b_10_A(Payment,Service,Employee,Employer,Termination,Reason),
    s3306_b_10_B(Employer,Payment,Plan).

%(A) upon or after the termination of an employee's employment relationship because of (i) death, or (ii) retirement for disability, and
s3306_b_10_A(Payment,Service,Employee,Employer,Termination,Reason) :-
	start_(Payment,Start_remuneration),
	termination_(Termination),
    agent_(Termination,Employer),
	patient_(Termination,Service),
	(start_(Termination,Start_termination); end_(Service,Start_termination)),
    is_before(Start_termination,Start_remuneration),
	reason_(Termination,Reason),
	(disability_(Reason); death_(Reason)),
	agent_(Reason,Employee).

%(B) under a plan established by the employer which makes provision for his employees generally or a class or classes of his employees (or for such employees or class or classes of employees and their dependents),
s3306_b_10_B(Employer,Remuneration,Plan) :-
	means_(Remuneration,Plan),
	plan_(Plan),
	agent_(Plan,Employer),
    purpose_(Plan,"make provisions for employees or dependents").

%other than any such payment or series of payments which would have been paid if the employee's employment relationship had not been so terminated;

%(11) remuneration for agricultural labor paid in any medium other than cash;
s3306_b_11(Remuneration,Agricultural_labor) :-
    service_(Agricultural_labor),
	purpose_(Agricultural_labor,"agricultural labor"),
	patient_(Agricultural_labor,Employer),
	agent_(Agricultural_labor,Employee),
    agent_(Remuneration,Employer),
	patient_(Remuneration,Employee),
	purpose_(Remuneration,Agricultural_labor),
	means_(Remuneration,Medium),
    Medium\=="cash".

%(15) any payment made by an employer to a survivor or the estate of a former employee after the calendar year in which such employee died;
s3306_b_15(Payment,Employer,Survivor,Employee) :-
    s3306_c(_,Employer,Employee,_,_,_),
	agent_(Payment,Employer),
	patient_(Payment,Survivor),
	start_(Payment,Start_remuneration),
	death_(Edeath),
	agent_(Edeath,Employee),
	start_(Edeath,Time_death),
    marriage_(Emar),
	agent_(Emar,Employee),
	agent_(Emar,Survivor),
	(\+ end_(Emar,_); end_(Emar,Time_death)),
    split_string(Start_remuneration,"-","",[Year_remuneration,_,_]),
	split_string(Time_death,"-","",[Year_death,_,_]),
	Year_remuneration@>Year_death.

%(c) Employment

%For purposes of this chapter, the term "employment" means any service, of whatever nature,

s3306_c(Service,Employer,Employee,Geographical_location,Day,Year) :-
	service_(Service),
    (
        (
            var(Day)
        );
        (
            nonvar(Day),
            split_string(Day,"-","",[Day_y,_,_]),
            atom_number(Day_y,Year)
        )
    ),
    ( 
        s3306_c_A(Service,Employer,Employee,Geographical_location);
        s3306_c_B(Service,Employer,Employee,Geographical_location)
	),
	\+ s3306_c_1(Service,Employer,Employee,Year),
	\+ s3306_c_2(Service,Employer,Year), 
	\+ s3306_c_5(Service,Employer,Employee,Day),
	\+ s3306_c_6(Service),
	\+ s3306_c_7(Service),
	\+ s3306_c_10(Service,Employer,Employee,Day),
	\+ s3306_c_11(Service,Employer,Employee),
	\+ s3306_c_13(Service,Employer,Employee,Day),
	\+ s3306_c_16(Service,Employer,Employee),
	\+ s3306_c_21(Service,Employer,Employee,Day).

%(A) performed by an employee for the person employing him, irrespective of the citizenship or residence of either, within the United States, and
s3306_c_A(Service,Person,Employee,Geographical_location) :-
	agent_(Service,Employee),
	patient_(Service,Person), 
    (
        location_(Service,Geographical_location);
        ( % by default, assume it's in the US
            \+ location_(Service,_),
            Geographical_location = "usa"
        )
    ),
    (
        (
            country_(Geographical_location,Country),
            Country=="usa"
        );
        (
            \+ country_(Geographical_location,_),
            Geographical_location=="usa"
        )
    ).

%(B) performed outside the United States (except in a contiguous country with which the United States has an agreement relating to unemployment compensation) by a citizen of the United States as an employee of an American employer, except-
s3306_c_B(Service,Employer,Employee,Geographical_location) :-
	agent_(Service, Employee),
	patient_(Service, Employer),
	(
        (
            country_(Geographical_location,Country),
            Country\=="usa"
        );
        (
            \+ country_(Geographical_location,_),
            Geographical_location\=="usa"
        )
    ),
	\+ (
		unemployment_compensation_agreement_(Agreement),
		agent_(Agreement,"usa"),
		agent_(Agreement,Geographical_location)
	),
    american_employer_(Employer_is_american_employer),
    agent_(Employer_is_american_employer,Employer),
	citizenship_(Employee_is_american),
	agent_(Employee_is_american,Employee),
    patient_(Employee_is_american,"usa").

%(1) agricultural labor unless-
s3306_c_1(Service,Employer,Employee,Year) :-
	(
		purpose_(Service,"agricultural labor");
        type_(Service,"agricultural labor")
	),
	\+ (
		s3306_c_1_A(Service,Employer,Year),
		s3306_c_1_B(Service,Employee)
	).

%(A) such labor is performed for a person who-
s3306_c_1_A(Service,Person,Year) :-
	patient_(Service,Person),
    nonvar(Year),
	(
		s3306_c_1_A_i(Person,Year);
		s3306_c_1_A_ii(Person,Year)
	).

%(i) during any calendar quarter in the calendar year or the preceding calendar year paid remuneration in cash of $20,000 or more to individuals employed in agricultural labor (including labor performed by an alien referred to in subparagraph (B)), or
s3306_c_1_A_i(Person,Year) :-
    last_day_year(Year,Last_day_year),
    Year1 is Year-1,
    first_day_year(Year1,First_day_year),
    findall(
        Amount,
        (
            payment_(Payment),
            agent_(Payment,Person),
            patient_(Payment,Employee),
            service_(Service),
            agent_(Service,Employee),
            patient_(Service,Person),
            (
                purpose_(Service,"agricultural labor");
                type_(Service,"agricultural labor")
            ),
            purpose_(Payment,Service),
            amount_(Payment,Amount),
            start_(Payment,Payment_time),
            is_before(First_day_year,Payment_time),
            is_before(Payment_time,Last_day_year),
            (
                (
                    \+ means_(Payment,_)
                );
                means_(Payment,"cash")
            )
        ),
        Amounts
    ),
    sum_list(Amounts,Total_amount),
    Total_amount >= 20000.

%(ii) on each of some 10 days during the calendar year or the preceding calendar year, each day being in a different calendar week, employed in agricultural labor (including labor performed by an alien referred to in subparagraph (B)) for some portion of the day (whether or not at the same moment of time) 5 or more individuals; and
s3306_c_1_A_ii(Person,Year) :-
	s3306_a_2_B(Person,Year).

%(B) such labor is not agricultural labor performed by an individual who is an alien admitted to the United States to perform agricultural labor.
s3306_c_1_B(Service,Individual) :-
	\+ (
	    (
			type_(Service,"agricultural labor");
			purpose_(Service,"agricultural labor")
		),
		citizenship_(Employee_citizenship),
		agent_(Employee_citizenship,Individual),
		patient_(Employee_citizenship,Country),
		Country \== "usa",
		migration_(Employee_migration),
		agent_(Employee_migration,Individual),
		destination_(Employee_migration,"usa"),
		purpose_(Employee_migration,"agricultural labor")
	).

%(2) domestic service in a private home, local college club, or local chapter of a college fraternity or sorority unless performed for a person who paid cash remuneration of $1,000 or more to individuals employed in such domestic service in any calendar quarter in the calendar year or the preceding calendar year;
s3306_c_2(Service,Person,Year) :-
	(
		type_(Service,"domestic service");
		purpose_(Service,"domestic service")
	),
    location_(Service,Location),
	(
		Location=="private home";
		Location=="local college club";
		Location=="local chapter of a college fraternity";
		Location=="local chapter of a college sorority"
	),
	\+ s3306_a_3(Person,Year,_).

%(5) service performed by an individual in the employ of his son, daughter, or spouse, and service performed by a child under the age of 21 in the employ of his father or mother;
s3306_c_5(Service,Employer,Individual,Day) :-
	service_(Service),
	agent_(Service,Individual),
	patient_(Service,Employer),
	(
        (
            (
                is_child_of(Employer,Individual,_,_)
            );
            (
                marriage_(Marriage),
                agent_(Marriage,Employer),
                agent_(Marriage,Individual),
                Employer\==Individual,
                start_(Marriage,Time_start),
                is_before(Time_start,Day),
                (
                    (
                        \+ end_(Marriage,_)
                    );
                    (
                        end_(Marriage,Time_end),
                        is_before(Day,Time_end)
                    )
                )
            )
        );
        (
            is_child_of(Individual,Employer,_,_),
            birth_(Birth_employee),
            agent_(Birth_employee,Individual),
            start_(Birth_employee,Date_of_birth),
            split_string(Date_of_birth,"-","",[Dob_y,Dob_m,Dob_d]),
            Day_offset is Dob_d+7671,
            date_time_stamp(date(Dob_y,Dob_m,Day_offset,0,0,0,0,-,-), Stamp_21),
            split_string(Day,"-","",[Year,Month,Day1]),
            date_time_stamp(date(Year,Month,Day1,0,0,0,0,-,-), Stamp_day),
            Stamp_21>Stamp_day
        )
    ).

%(6) service performed in the employ of the United States Government
s3306_c_6(Service) :-
	patient_(Service,Employer),
	Employer=="united states government".

%(7) service performed in the employ of a State, or any political subdivision thereof.
s3306_c_7(Service) :-
	patient_(Service,Employer),
	atom_prefix(Employer,"state of ").

%(10)
s3306_c_10(Service,Employer,Employee,Day) :-
	s3306_c_10_A(Service,Employer,Employee,Day);
	s3306_c_10_B(Service,Employer,Employee,Day).

%(A) service performed in the employ of a school, college, or university, if such service is performed
s3306_c_10_A(Service,Employer,Employee,Day) :-
	patient_(Service,Employer),
	agent_(Service,Employee),
	educational_institution_(Employer_is_an_educational_institution),
	agent_(Employer_is_an_educational_institution,Employer),
	(
		s3306_c_10_A_i(Employee,Employer,Day);
		s3306_c_10_A_ii(_,Employee,Employer,Day)
	).

%(i) by a student who is enrolled and is regularly attending classes at such school, college, or university, or
s3306_c_10_A_i(Student,Educational_institution,Service_day) :-
	enrollment_(Student_is_enrolled),
	agent_(Student_is_enrolled,Student),
	patient_(Student_is_enrolled,Educational_institution),
	start_(Student_is_enrolled,Start_enrollment),
	attending_classes_(Student_attends_classes),
	agent_(Student_attends_classes,Student),
	location_(Student_attends_classes,Educational_institution),
	start_(Student_attends_classes,Start_attendance),
	is_before(Start_enrollment,Service_day),
	is_before(Start_attendance,Service_day),
	(
		(
			\+ end_(Student_is_enrolled,_)
		);
		(
			end_(Student_is_enrolled,Stop_enrollment),
			is_before(Service_day,Stop_enrollment)
		)
	),
	(
		(
			\+ end_(Student_attends_classes,_)
		);
		(
			end_(Student_attends_classes,Stop_attendance),
			is_before(Service_day,Stop_attendance)
		)
	).

%(ii) by the spouse of such a student, or
s3306_c_10_A_ii(Spouse,Student,Educational_institution,Day) :-
    split_string(Day,"-","",[YS,_,_]),
    atom_number(YS,Year),
    s7703(Student,Spouse,Marriage,_,_,_,_,_,Year),
	(
		(
			\+ start_(Marriage,_)
		);
		(
			start_(Marriage,Start_marriage),
			is_before(Start_marriage,Day)
		)
	),
	(
		(
			\+ end_(Marriage,_)
		);
		(
			end_(Marriage,End_marriage),
			is_before(Day,End_marriage)
		)
	),
	s3306_c_10_A_i(Spouse,Educational_institution,Day).

%(B) service performed in the employ of a hospital, if such service is performed by a patient of such hospital;
s3306_c_10_B(Service,Employer,Employee,Day) :-
	patient_(Service,Employer),
	agent_(Service,Employee),
	hospital_(Employer_is_hospital),
	agent_(Employer_is_hospital,Employer),
	medical_patient_(Employee_is_medical_patient),
	agent_(Employee_is_medical_patient,Employee),
	patient_(Employee_is_medical_patient,Employer),
	start_(Employee_is_medical_patient,Start_patient),
	is_before(Start_patient,Day),
	(
		(
			\+ end_(Employee_is_medical_patient,_)
		);
		(
			end_(Employee_is_medical_patient,End_patient),
			is_before(Day,End_patient)
		)
	).

%(11) service performed in the employ of a foreign government (including service as a consular or other officer or employee or a nondiplomatic representative);
s3306_c_11(Service,Employer,Employee) :-
	patient_(Service,Employer),
	agent_(Service,Employee),
	sub_atom(Employer,_,11,0,Suffix),
	Suffix==' government',
	Employer\=="united states government".

%(13) service performed as a student nurse in the employ of a hospital or a nurses' training school by an individual who is enrolled and is regularly attending classes in a nurses' training school; and service performed as an intern in the employ of a hospital by an individual who has completed a 4 years' course in a medical school;
s3306_c_13(Service,Employer,Employee,Day) :-
	patient_(Service,Employer),
	agent_(Service,Employee),
	nurses_training_school_(Employer_is_nurses_training_school),
	agent_(Employer_is_nurses_training_school,Employer),
	enrollment_(Student_is_enrolled),
	agent_(Student_is_enrolled,Student),
	patient_(Student_is_enrolled,Employer),
	start_(Student_is_enrolled,Start_enrollment),
	attending_classes_(Student_attends_classes),
	agent_(Student_attends_classes,Student),
	location_(Student_attends_classes,Employer),
	start_(Student_attends_classes,Start_attendance),
	is_before(Start_enrollment,Day),
	is_before(Start_attendance,Day),
	(
		(
			\+ end_(Student_is_enrolled,_)
		);
		(
			end_(Student_is_enrolled,Stop_enrollment),
			is_before(Day,Stop_enrollment)
		)
	),
	(
		(
			\+ end_(Student_attends_classes,_)
		);
		(
			end_(Student_attends_classes,Stop_attendance),
			is_before(Day,Stop_attendance)
		)
	).

%(16) service performed in the employ of an international organization;
s3306_c_16(Service,Employer,Employee) :-
	patient_(Service,Employer),
	agent_(Service,Employee),
	international_organization_(Employer_is_international_organization),
	agent_(Employer_is_international_organization,Employer).

%(21) service performed by a person committed to a penal institution.
s3306_c_21(Service,Employer,Employee,Day) :-
	patient_(Service,Employer),
	agent_(Service,Employee),
	penal_institution_(Jail_is_a_penal_institution),
	agent_(Jail_is_a_penal_institution,Jail),
	incarceration_(Employee_goes_to_jail),
	agent_(Employee_goes_to_jail,Employee),
	patient_(Employee_goes_to_jail,Jail),
	start_(Employee_goes_to_jail,Start_incarceration),
	is_before(Start_incarceration,Day),
	(
		(
			\+ end_(Employee_goes_to_jail,_)
		);
		(
			end_(Employee_goes_to_jail,End_incarceration),
			is_before(Day,End_incarceration)
		)
	).
