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
    6,6,6,8,5,4,4,8,9,4,0];  % 需求点间运输时间表


customers_demand =[
    1,2,3,4,5,6,7,8,9,10;
    718270*3,123370*3,102100*3,81900*3,255450*3,81900*3,204400*3,204460*3,177140*3, 184740*3];% 需求点对物资的需求量
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
    2,7]'; % 需求点对运输过程的时间窗约束
customer = [customers_demand;customers_time];   %需求点的基本信息（需求点编号，需求量，时间窗约束）
fleet_num = 900;
num_of_vehicles = [1,2,3,4,5,6,7,8,9,10]; %车辆编号
n = length(num_of_vehicles);%自动计算车俩的数量，方便初始化
situation_of_vehicles = [15000*fleet_num,15000*fleet_num,20000*fleet_num,20000*fleet_num,25000*fleet_num,25000*fleet_num,40000*fleet_num,40000*fleet_num,40000*fleet_num,40000*fleet_num];%物流企业货车载重情况表
prices_of_vehicles = [100*fleet_num, 100*fleet_num, 150*fleet_num, 150*fleet_num, 200*fleet_num, 200*fleet_num, 250*fleet_num, 250*fleet_num, 250*fleet_num, 250*fleet_num];% Define an array to store the prices for each vehicle
time_of_vehicles = ones(1,n)*10; %车辆的最大运输时间
vehicle = [num_of_vehicles;situation_of_vehicles;time_of_vehicles;prices_of_vehicles];%第一行为车辆编号，第二行为载重，第三行为剩余时间

number_of_car = size(num_of_vehicles,2); %拥有汽车数量
cost_sortage = 0.44; % 每吨的早送到的每天储存成本
deadline_cost = 4000; % 延迟送到的延误成本，单位每天


espo = 100  ;  %种群数量
popsize = espo;
Generationnmax=3;  %最大代数

%% 产生初始种群,返回的select为车辆路径、车辆编号、单位运费的结构体
path = initialization(transport_time,customer,vehicle,espo,n);


%% 计算适应度,返回适应度Fitvalue和累积概率cumsump
new_path =fitnessfun(path,transport_time,customer,cost_sortage,deadline_cost,number_of_car) ;
%% 
Generation=1;
while Generation < Generationnmax+1
   for j=1:2:popsize
      %选择操作
      [father_1,father_2] = selection(new_path);
      %交叉操作
      [path_1_infor_1,path_1_infor_2]=crossover(father_1,father_2,transport_time,customer,number_of_car);
      %变异操作
      snnew_1=mutation(path_1_infor_1,transport_time,number_of_car,vehicle,customer);
      new_f(j).infor = snnew_1;
      snnew_2=mutation(path_1_infor_2,transport_time,number_of_car,vehicle,customer);
      new_f(j+1).infor = snnew_2;
      j
   end
   path = new_f;  %产生了新的种群 
   %计算新种群的适应度   
   new_path = fitnessfun(path,transport_time,customer,cost_sortage,deadline_cost,number_of_car)
   %记录当前代最好的适应度和平均适应度
   Generation = Generation+1
end
new_path