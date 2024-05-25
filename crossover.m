%�ӳ�������Ⱥ�������,�������ƴ洢Ϊcrossover.m
function [path_1_infor_1,path_1_infor_2]=crossover(father_1,father_2,transport_time,customer,number_of_car)
    global path_1_infor_1 ;
    global  path_1_infor_2 ;
    path_1_infor = father_1.infor;
    path_2_infor = father_2.infor;
    % ���ѡȡ�������õ�·��L1��L2
    a = false;
    vehicle_1 = 0;
    vehicle_2 = 0;
    while a == false
        aa =false;
        aaa = false;
        c_1 = 0;
        c_2 = 0;
        vehicle_1 = floor(rand(1,1) * (number_of_car-1) +1);
        c_1 = sum(ismember(path_1_infor(1,:),vehicle_1));
        if c_1 ~= 0
            aa = true;
        end
        vehicle_2 = floor(rand(1,1) * (number_of_car-1) +1);
        c_2 = sum(ismember(path_2_infor(1,:),vehicle_2));
        if c_2 ~= 0
            aaa = true;
        end
        a = aa && aaa;
    end 
    % ��������ѡȡ��·���Ļ���ɾ����
    %������һ�е�vehicle_1�Ļ�����ȡΪ
    L1 = path_1_infor( :,path_1_infor(1,:) == vehicle_1);
    L1(:,1) = [];
    %������2�е�vehicle_2�Ļ�����ȡ
    L2 = path_2_infor( :,path_2_infor(1,:) == vehicle_2);
    L2(:,1) = [];
    %������һ�е�����Ӧ��L2�Ļ���ɾ��
    for i = 1:size(L2,2)
        value =  L2(3,i);
        path_1_infor(: , path_1_infor(3,:) == value) = [];
    end
        %���������е�����Ӧ��L1�Ļ���ɾ��
    for i = 1:size(L1,2)
            value =L1(3,i);
            path_2_infor(: , path_2_infor(3,:) == value) = [];
    end

    
    % ��·��L�ϵĻ����ճɱ�������С��ԭ�����β��뵽������
    %% ��·��L2�ϵĻ����ճɱ�������С��ԭ�����β��뵽����1��
    
    nnew_path_1.infor = path_1_infor;
    nnew_path_1.cost = [];
    for j = 1 : size(L2,2)
        insert_L2 = L2(:,j);
        
        new_path_1 = nnew_path_1;
        nnew_path_1 = [];
        for i = 1 : size(new_path_1,2)
            
            for jj = 1 : size( new_path_1(i).infor,2)
                if jj == size(new_path_1(i).infor, 2)
                    nnew_path_1(end+1).infor = [new_path_1(i).infor(:,1:jj),insert_L2];
                    nnew_path_1(end).infor(1:2,end) = nnew_path_1(end).infor(1:2,end-1);
                else
                    insert_left = new_path_1(i).infor(:,1:jj);
                    insert_right = new_path_1(i).infor(:,jj+1:end);
                    nnew_path_1(end+1).infor = [insert_left,insert_L2,insert_right];
                    nnew_path_1(end).infor(1:2,jj+1) = nnew_path_1(end).infor(1:2,jj);
                end
                [~,total_cost] = calculate_cost(nnew_path_1(end).infor,transport_time,customer,number_of_car);
                nnew_path_1(end).cost = total_cost;
            end
        end
    end
    nnew_path_1;
    if isempty(nnew_path_1(1).cost)
        path_1_infor_1 = nnew_path_1.infor;
    else
        [~,index]=sort([nnew_path_1.cost],'ascend');
        most_new_path = nnew_path_1(index);
        path_1_infor_1 = most_new_path(1).infor;
    end

    %% ��·��L1�ϵĻ����ճɱ�������С��ԭ�����β��뵽����2��n
    
    nnew_path_2.infor = path_2_infor;
    nnew_path_2.cost = [];
    for j = 1 : size(L1,2)
        insert_L1 = L1(:,j);
        
        new_path_2 = nnew_path_2;
        nnew_path_2 = [];
        for i = 1 : size(new_path_2,2)
            
            for jj = 1 : size( new_path_2(i).infor,2)
                if jj == size(new_path_2(i).infor, 2)
                    nnew_path_2(end+1).infor = [new_path_2(i).infor(:,1:jj),insert_L1];
                    nnew_path_2(end).infor(1:2,end) = nnew_path_2(end).infor(1:2,end-1);
                else
                    insert_left = new_path_2(i).infor(:,1:jj);
                    insert_right = new_path_2(i).infor(:,jj+1:end);
                    nnew_path_2(end+1).infor = [insert_left,insert_L1,insert_right];
                    nnew_path_2(end).infor(1:2,jj+1) = nnew_path_2(end).infor(1:2,jj);
                end
                [~,total_cost] = calculate_cost(nnew_path_2(end).infor,transport_time,customer,number_of_car);
                nnew_path_2(end).cost = total_cost;
            end
        end
    end
    nnew_path_2;
    if isempty( nnew_path_2(1).cost)
        path_1_infor_2 =  nnew_path_2.infor;
    else
        [~,index]=sort([nnew_path_2.cost],'ascend');
        most_new_path = nnew_path_2(index);
        path_1_infor_2 = most_new_path(1).infor;
    end
 
   
   
   
   
   
   