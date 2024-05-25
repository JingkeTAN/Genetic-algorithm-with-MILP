%�ӳ��򣺼�����Ӧ�Ⱥ���, �������ƴ洢Ϊfitnessfun
function new_path =fitnessfun(path,transport_time,customer,cost_sortage,deadline_cost,number_of_car)

%number_of_car = size(num_of_vehicles,2) %ӵ����������
% cost_sortage = 0.44; % ÿ�ֵ����͵���ÿ�촢��ɱ�
% deadline_cost = 4000; % �ӳ��͵�������ɱ�����λÿ��



% ����ÿ����������Ӧ������ɱ�
for i = 1:size(path,2)
    date_cost = 0;
    date =zeros(1,number_of_car);
    transport_cost = 0; %һ�����彫�����гɱ����㣬���ڳɱ�������ɱ�

    for j = 1:size(path(i).infor,2)-1
        %����ȡֵ��num_vehΪ���͵ĳ�����ţ�num_costΪ��Ϊ����ɱ�customer_i-->j��·��
        num_veh = path(i).infor(1,j);
        num_cost = path(i).infor(2,j);
        customer_i = path(i).infor(3,j);
        customer_j = path(i).infor(3,j + 1);
        %��������ɱ���������ʱ�䴰
        if customer_j == 0
            continue
        else
            customer_demand = customer(2,customer_j);
            transport_cost = transport_cost + num_cost * customer_demand;
            eary_date = customer(3,customer_j);
            deadline_date = customer(4,customer_j);
            date(num_veh) = date(num_veh) + transport_time(customer_i + 1,customer_j + 1);
            % �����絽�ĳɱ�
            if date(num_veh) < eary_date
                date_cost = date_cost + (eary_date - date(num_veh)) * customer_demand / 1000 * cost_sortage;
            end
            % �������ĳɱ�
            if date(num_veh) > deadline_date
                date_cost = date_cost + (date(num_veh) - deadline_date) * deadline_cost;
            end
        end
    end
   for x = 1:size(path(i).infor,2)-1
        xx = path(i).infor(3,x);
        yy = path(i).infor(3,x+1);
        a =[];
        a(1,size(path(i).infor,2)) = 0;
        if xx == 0 && yy == 0
            a(1,x) = path(i).infor(1,x);
        end
    end
    path(i).infor(:,path(i).infor(1,:) == a ) = [];
    N = numel(find(path(i).infor ==0 )); % һ�������еĳ�������
    path(i).cost = date_cost + transport_cost;
    path(i).Num = N;
end
%% ����ÿһ��������� 
for i = 1:size(path,2)
   cost_total = path(i).cost;
   num_total = path(i).Num;
   path(i).series = 0;
   for j = 1:size(path,2)
       if cost_total > path(j).cost && num_total > path(j).Num
           path(i).series = path(i).series + 1;
       end
   end
end
[~,index]=sort([path.series],'ascend');
new_path = path(index);


%% �����������ѡ����ʣ����Ϊ1�����Ϊ0.��ʽ������
q = 1;
q0 = 0;
path_size = size(new_path,2);
r = path_size;
f = (q - q0)/r;
for i = 1 : path_size
    p = q-(i -1)*f;
    new_path(i).choice = p;
end










