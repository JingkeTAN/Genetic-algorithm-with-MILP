% �˴�����һ������ɱ��ĺ���,���ش�����ֵ��·�����ܳɱ�
function [path_cost,total_cost] = calculate_cost(path_infor,transport_time,customer,number_of_car)
transport_cost = 0;
date_cost = 0;
date = zeros(number_of_car,1); % Ԥ�ȷ����ڴ�
quntity_demand = customer(2,:); % ��ȡ�ͻ�������
early_date = customer(3,:); % ��ȡ�ͻ���������
lately_date = customer(4,:); % ��ȡ�ͻ���������
for j = 1 : size(path_infor,2)-1 % ȡ��i��j�Ŀͻ����� 
    customer_i = path_infor(3,j); 
    customer_j = path_infor(3,j+1); 
    %Ϊ�����͵ĳ����ı�� 
    num = path_infor(1,j+1); 
    if customer_j == 0 
        continue; 
    else 
        transport_cost = transport_cost + quntity_demand(customer_j) * path_infor(2,j +1); % ʹ����ֵ����
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
