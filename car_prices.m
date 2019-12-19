function car_prices()
purge
format long g

years_of_use = 0:17;

[own_car,no_car,car_price,lyft_price] = compute_prices(years_of_use);

plot(years_of_use,own_car,'b-')
hold on
plot(years_of_use,no_car,'r-')
legend('Owning Car','No Car')

figure()
plot(years_of_use,car_price)
hold on
plot(years_of_use,lyft_price,'r-')
legend('Owning Car','No Car')
ylabel('Price Per Mile')


function [total_price_of_owning_car,total_price_no_car,car_price_per_mile,lyft_price_per_mile] = compute_prices(years_of_use)
%%%%Computation of mileage and trips
%years_of_use = 10;

%%%Work
commute_distance = 4; %%%rountrip
num_trips_to_work = 0*5*52; %%5 days a week and 52 weeks in a year
mileage_to_work = commute_distance*num_trips_to_work;

%%%Play on weekends
play_distance = 20; %%%to downtown and back or say schillinger or something
num_trips_to_play = 2*52; %%%2 per week 
mileage_play = num_trips_to_play*play_distance;

%%%Road Trips
road_trip_distance = 1000;
num_road_trips = 0; %%%say 7 per year? Beach House, Huntsville, Atlanta, Thanksgiving, Christmas, etc
mileage_road_trips = road_trip_distance*num_road_trips;

%%%%Computed Mileage
total_mileage = (mileage_road_trips+mileage_play+mileage_to_work)*years_of_use;

%%%Car specifics
price_of_car = 17000;
sell_price = price_of_car - years_of_use*1000; %%%Assume linear
                                               %even though this is
                                               %not true in the slightest
total_car_price = price_of_car-sell_price; 

%%%oil change price
num_oil_changes = total_mileage/5000;
oil_change_price = 50;
total_oil_price = oil_change_price*num_oil_changes;

%%%30,60 and 100K checkups
price_checkups_vec = [200,200,500];
price_checkups = sum(price_checkups_vec);

%%%Tire Rotation is usually every 2 oil changes but is free
%%%Tires from the lot suck and are replaced at 30K.
%%%But the new tires last 70K so this is just one cost
tire_cost = 600;

%%%Vehicle Registration is every year
registration_taxes = 250;
total_reg_tax = registration_taxes*years_of_use;

%%%%Routine Maintenance - Keep in mind my car has 80K and hasn't 
%%%%had any major issues
maintenance_cost = (2000/10)*years_of_use; %%%Massive over estimate

%%%Gas
gas_price = 2.50; %%%Let's assume a nominal value. Might need to change this
mpg = 25; %%%Let's use a moderate estimate as well
total_price_gas = (total_mileage/mpg)*gas_price;

%%%Insurance
insurance_per_year = 600;
total_insurance = insurance_per_year*years_of_use;

%%%TOTAL COST OF OWNING A CAR
total_price_of_owning_car = total_car_price + total_oil_price+ ...
    price_checkups+tire_cost+total_reg_tax+maintenance_cost+total_price_gas+total_insurance;

%%%Lets compute the price of this car per mile
car_price_per_mile = total_price_of_owning_car./total_mileage;

%%%%Ok now let's do Lyft/Uber/Rental Cars
%%%I took a lyft from my Airbnb to the airport. With $5 tip it was
%%%48.25 and 23 miles away. This is probably an over estimate but hey
%%%it will work.
lyft_price_per_mile = 48.25/23*ones(1,length(years_of_use)); %%%does it work this way? - need to check this out.

%%%I need to get to work so 
price_per_trip = lyft_price_per_mile*commute_distance;
LU_work_price = price_per_trip.*num_trips_to_work.*years_of_use;

%%%I'd still like to play on the weekends although you could probably argue
%%%the use of one car on weekends but anyway
price_per_play = lyft_price_per_mile*play_distance;
LU_play_price = price_per_play.*num_trips_to_play.*years_of_use;

%%%Road Trips would require a rental car. Each rental car would
%probably be like that time we went to the beach house which was
%$250
rental_car_price = 250;
RC_total_price = rental_car_price*num_road_trips*years_of_use;

%%%%TOTAL PRICE OF NOT OWNING A CAR
total_price_no_car = LU_work_price+LU_play_price+RC_total_price;

%%%Ok. Is there a break even point? This is tough to
%determine because although oil changes are linear, maintenance and
%sell price is highly non-linear. It's possible that older cars
%will begin to cost more than they are worth but that's difficult
%to determine. Still let's see if we can create a better model

%%%Ok so it looks like there is a massive up front cost with
%purchasing the car but it quickly goes away since Lyft is still
%very expensive. So at $2/mile you go over. I guess we could
%compute this break even point

%%%Ok so according to my analysis. Unless Uber or Lyft becomes less than $1
%%%per mile it will still be cheaper to own a car. It'd be interesting to
%%%try a lyft one day just to see how expensive it would be. 

