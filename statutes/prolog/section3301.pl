%§3301. Rate of tax

%There is hereby imposed on every employer (as defined in section 3306(a)) for each calendar year an excise tax, with respect to having individuals in his employ, equal to 6 percent of the total wages (as defined in section 3306(b)) paid by such employer during the calendar year with respect to employment (as defined in section 3306(c)).
s3301(Employer,Year,Total_wages,Tax) :-
    first_day_year(Year,First_day_year),
    last_day_year(Year,Last_day_year),
    s3306_a(Employer,Year,_),
    total_wages_employer(Employer,Total_wages,First_day_year,Last_day_year),
    Tax is round(0.06*Total_wages).

total_wages_employer(Employer,Total_wages,Start_day,End_day) :-
    % some individual's wage is the sum of that person's wages, capped at $7000 (as per §3301(b)(1))
    findall(
        (Individual,Wages),
        (
            s3306_b(Wages,Remuneration_event,_,Employer,Individual,_,_,_,_,Employer,_),
            start_(Remuneration_event,Remuneration_time),
            is_before(Start_day,Remuneration_time),
            is_before(Remuneration_time,End_day)
        ),
        Individuals_x_wages
    ),
    findall(
        Individual,
        member((Individual,_),Individuals_x_wages),
        Individual_list
    ),
    list_to_set(Individual_list,Individual_set),
    findall(
        (Individual,Total_wage),
        (
            member(Individual, Individual_set),
            findall(
                Wage,
                member((Individual,Wage),Individuals_x_wages),
                Individual_wages
            ),
            sum_list(Individual_wages,Wage_sum),
            s3306_b_1(Wage_sum,Total_wage)
        ),
        Individuals_x_capped_wages
    ),
    findall(
        Wage,
        (
            member(Individual,Individual_set),
            member((Individual,Wage),Individuals_x_capped_wages)
        ),
        Capped_wages
    ),
    sum_list(Capped_wages,Total_wages).
