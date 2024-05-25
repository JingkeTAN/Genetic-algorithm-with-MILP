% 此处引入一个计算成本的函数,返回带有总值的路径和总成本
function [path_cost,total_cost] = calculate_cost(path_infor,transport_time,customer,number_of_car)
transport_cost = 0;
date_cost = 0;
date = zeros(number_of_car,1); % 预先分配内存
quntity_demand = customer(2,:); % 提取客户需求量
early_date = customer(3,:); % 提取客户最早日期
lately_date = customer(4,:); % 提取客户最晚日期
for j = 1 : size(path_infor,2)-1 % 取出i到j的客户名字 
    customer_i = path_infor(3,j); 
    customer_j = path_infor(3,j+1); 
    %为其配送的车辆的编号 
    num = path_infor(1,j+1); 
    if customer_j == 0 
        continue; 
    else 
        transport_cost = transport_cost + quntity_demand(customer_j) * path_infor(2,j +1); % 使用数值索引
        date(num) = date(num) + transport_time(customer_i+1,customer_j+1); 
        if date(num) < early_date(customer_j) 
            date_cost = date_cost + quntity_demand(customer_j) * 0.44 / 1000 *(early_date(customer_j) - date(num)); 
        end 
        if date(num) > lately_date(customer_j) 
            date_cost = date_cost + (date(num) - lately_date(customer_j)) * 4000; 
        end 
    end 
    path_infor(4,j+1) = lately_date(customer_j) +date_cost; 
end

path_cost = path_infor;
total_cost = transport_cost+date_cost;
