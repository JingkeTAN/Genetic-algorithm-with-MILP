clear;
clc;
transport_time = [
    0,1,1,2,2,2,3,3,4,4,6;...
    1,0,1,2,3,3,4,4,4,5,6;...
    1,2,0,1,3,3,4,3,3,5,6;...
    2,2,1,0,3,5,4,2,3,6,8;...
    2,3,3,3,0,5,1,4,5,6,5;...
    2,3,3,5,5,0,6,6,7,2,4;...
    3,4,4,4,1,6,0,4,4,7,4;...
    3,4,3,2,4,6,4,0,1,8,8;...
    4,4,3,3,5,7,4,1,0,9,9;...
    4,5,5,6,6,2,7,8,9,0,4;...
    6,6,6,8,5,4,4,8,9,4,0];  % ����������ʱ���


customers_demand =[
    1,2,3,4,5,6,7,8,9,10;
    718270*3,123370*3,102100*3,81900*3,255450*3,81900*3,204400*3,204460*3,177140*3, 184740*3];% ���������ʵ�������
customers_time = [
    1,2;
    2,5;
    3,5;
    4,7;
    3,10;
    11,14;
    4,6;
    7,11;
    5,6;
    2,7]'; % ������������̵�ʱ�䴰Լ��
customer = [customers_demand;customers_time];   %�����Ļ�����Ϣ��������ţ���������ʱ�䴰Լ����
fleet_num = 900;
num_of_vehicles = [1,2,3,4,5,6,7,8,9,10]; %�������
n = length(num_of_vehicles);%�Զ����㳵���������������ʼ��
situation_of_vehicles = [15000*fleet_num,15000*fleet_num,20000*fleet_num,20000*fleet_num,25000*fleet_num,25000*fleet_num,40000*fleet_num,40000*fleet_num,40000*fleet_num,40000*fleet_num];%������ҵ�������������
prices_of_vehicles = [100*fleet_num, 100*fleet_num, 150*fleet_num, 150*fleet_num, 200*fleet_num, 200*fleet_num, 250*fleet_num, 250*fleet_num, 250*fleet_num, 250*fleet_num];% Define an array to store the prices for each vehicle
time_of_vehicles = ones(1,n)*10; %�������������ʱ��
vehicle = [num_of_vehicles;situation_of_vehicles;time_of_vehicles;prices_of_vehicles];%��һ��Ϊ������ţ��ڶ���Ϊ���أ�������Ϊʣ��ʱ��

number_of_car = size(num_of_vehicles,2); %ӵ����������
cost_sortage = 0.44; % ÿ�ֵ����͵���ÿ�촢��ɱ�
deadline_cost = 4000; % �ӳ��͵�������ɱ�����λÿ��


espo = 100  ;  %��Ⱥ����
popsize = espo;
Generationnmax=3;  %������

%% ������ʼ��Ⱥ,���ص�selectΪ����·����������š���λ�˷ѵĽṹ��
path = initialization(transport_time,customer,vehicle,espo,n);


%% ������Ӧ��,������Ӧ��Fitvalue���ۻ�����cumsump
new_path =fitnessfun(path,transport_time,customer,cost_sortage,deadline_cost,number_of_car) ;
%% 
Generation=1;
while Generation < Generationnmax+1
   for j=1:2:popsize
      %ѡ�����
      [father_1,father_2] = selection(new_path);
      %�������
      [path_1_infor_1,path_1_infor_2]=crossover(father_1,father_2,transport_time,customer,number_of_car);
      %�������
      snnew_1=mutation(path_1_infor_1,transport_time,number_of_car,vehicle,customer);
      new_f(j).infor = snnew_1;
      snnew_2=mutation(path_1_infor_2,transport_time,number_of_car,vehicle,customer);
      new_f(j+1).infor = snnew_2;
      j
   end
   path = new_f;  %�������µ���Ⱥ 
   %��������Ⱥ����Ӧ��   
   new_path = fitnessfun(path,transport_time,customer,cost_sortage,deadline_cost,number_of_car)
   %��¼��ǰ����õ���Ӧ�Ⱥ�ƽ����Ӧ��
   Generation = Generation+1
end
new_path