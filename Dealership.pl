% --- Car Inventory ---
% vehicle(Brand, Reference, Type, Price, Year)
vehicle(toyota, 95230, sedan, 42700, 2011).
vehicle(toyota, 96929, sedan, 37000, 2008).
vehicle(toyota, 22902, sedan, 41900, 2020).
vehicle(bmw, 45102, sedan, 33700, 2017).
vehicle(bmw, 44252, sedan, 32200, 2019).
vehicle(bmw, 54423, sedan, 30700, 2007).
vehicle(ford, 84183, sedan, 22700, 2011).
vehicle(toyota, 37161, suv, 55600, 2020).
vehicle(toyota, 33147, suv, 31500, 2022).
vehicle(toyota, 30817, suv, 38000, 2015).
vehicle(bmw, 70123, suv, 40200, 2007).
vehicle(bmw, 51612, suv, 38000, 2016).
vehicle(bmw, 90664, suv, 30700, 2009).
vehicle(ford, 58418, suv, 53600, 2006).
vehicle(ford, 29644, suv, 57500, 2022).
vehicle(ford, 87251, suv, 56600, 2011).
vehicle(bmw, 19505, pickup, 51100, 2009).
vehicle(ford, 46352, pickup, 59200, 2012).
vehicle(ford, 40108, pickup, 50500, 2013).
vehicle(ford, 79729, pickup, 56100, 2010).
vehicle(toyota, 66901, pickup, 53600, 2022).
vehicle(ford, 70947, sport, 65400, 2015).
vehicle(ford, 22539, sport, 59200, 2008).
vehicle(toyota, 54328, sport, 54000, 2005).
vehicle(toyota, 69336, sport, 64200, 2011).
vehicle(bmw, 44713, sport, 55900, 2017).
vehicle(bmw, 31378, sport, 62500, 2015).
% --- Basic queries ---
meet_budget(Reference, BudgetMax) :-
    vehicle(_, Reference, _, Price, _),
    Price =< BudgetMax.

find_brand(Brand, Brandcars) :-
    findall(Reference, 
          vehicle(Brand, Reference, _, _, _), 
    	  Brandcars).

meet_type(Type, Budget, Carlist) :-
    findall(Reference, 
          (
          vehicle(_, Reference, Type, _, _),
          meet_budget(Reference, Budget)
          ), 
    	  Carlist).
% --- Filter by size ---
generate_report(Brand, Type, Budget, Result) :-
    findall(vehicle(Brand, Reference, Type, Price),
            (vehicle(Brand, Reference, Type, Price, _), Price =< Budget),
            BrandTypeVehicles),
    filter_budget(BrandTypeVehicles, Budget, [], 0, Result).


filter_budget([vehicle(B, R, T, Price)|Other], MaxTotal, Acc, CurrentTotal, Result) :-
    NewTotal is CurrentTotal + Price,
    ( NewTotal =< MaxTotal ->
        filter_budget(Other, MaxTotal, [vehicle(B, R, T, Price)|Ac], NewTotal, Result)
    ;   reverse(Ac, Result)
    ).