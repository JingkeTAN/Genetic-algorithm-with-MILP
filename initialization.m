function path = initialization(transport_time,customer,vehicle,espo,n)
path(espo).infor = []; 
espoo = 1;
while espoo <= espo
    customers = customer;
    vehicles = vehicle;
    
    %������·����ʼ��

 for i = 1:n 
     select(i).path = 0; 
     select(i).num = i;
     select(i).price = vehicles(4,i); 
 end
    %
 %�������ó���������   
%    for v = 1:n
    % Assign the number for each vehicle
%    select(v).num = v;
    % Ask the user to input the price for each vehicle
%    select(v).price = input(['�������',num2str(v),'�����ļ۸�']);
%    end
    
    
    cus = false ;
    while cus ==  false
        % ȡ������������������������������ֵΪ�ա�
        max_demand = max(customers(2,:)) ;
        [i,j] = find(customers == max_demand);
        customer_i = customers(1,j(1));
        customers(: ,j(1)) = [];
        vel = false;
        %���гɱ��ļ���
        while vel == false
            % ���ѡȡ����
            a = floor(rand(1,1)*size(vehicles,2)+1);
            num = select(a).path(1,end);
            %ȡ����������˵ص�ʱ��
            t = transport_time(num+1,customer_i + 1);
            % �жϳ����Ƿ�����������������ʱ���Ҫ��
            if vehicles(2,a) >= max_demand && vehicles(3,a) > t
                % ���Ϊ�棬����·��������ʱ�䣬����ʣ��������,�� vel = true
                select(a).path(end + 1) = customer_i;
                vehicles(2,a) = vehicles(2,a) - max_demand;
                vehicles(3,a) = vehicles(3,a) - t;
                vel = true;
            end
        end
        if isempty(customers)
            cus = true;
        end
    end
 % ��·�������ᴿ���õ��ĳ���ȥ��
    for pat = 1:size(select,2)
        if select(pat).path(end) == 0
            continue
        else
            for path_num = 1:size(select(pat).path,2)
                path(espoo).infor(1,end+1) = select(pat).num;
                path(espoo).infor(2,end) = select(pat).price;
                path(espoo).infor(3,end) = select(pat).path(1,path_num);
            end
        end
    end
    espoo =espoo + 1;
end
end
% �������·���������

