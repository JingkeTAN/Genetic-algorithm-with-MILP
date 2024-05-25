function isok = MP1MP2(Path,transport_time,number_of_car,vehicle,customer)
% This function checks if a given path satisfies the time and capacity constraints
% Input: Path: a 3-by-n matrix, where each column represents a vehicle, a customer and a sequence number
%        transport_time: a m-by-m matrix, where each element represents the travel time between two customers (including depot)
%        number_of_car: a scalar, the number of vehicles
%        vehicle: a 2-by-number_of_car matrix, where each column represents a vehicle ID and its capacity
%        customer: a 2-by-m-1 matrix, where each column represents a customer ID and its demand
% Output: isok: a logical value, true if the path satisfies the constraints, false otherwise

% Initialize the time and gross load vectors for each vehicle
time = zeros(1,number_of_car);
gross_load = zeros(1,number_of_car);

% Loop through each vehicle
for v = 1:number_of_car
    % Extract the path of the current vehicle
    path_v = Path(:,Path(1,:)==v);
    % Extract the customer IDs of the current path
    cust_v = path_v(3,:);
    % Calculate the travel time of the current path by indexing the transport_time matrix
    travel_time_v = sum(diag(transport_time(cust_v+1,cust_v+1),1));
    % Calculate the gross load of the current path by indexing the customer matrix
    gross_load_v = sum(customer(2,cust_v(cust_v~=0)));
    % Update the time and gross load vectors
    time(v) = travel_time_v;
    gross_load(v) = gross_load_v;
end

% Check if any vehicle exceeds the time or capacity limit
exceed_time = any(time > 30);
exceed_capacity = any(gross_load > vehicle(2,:));

% Return the logical value of isok
isok = ~(exceed_time || exceed_capacity);
end
