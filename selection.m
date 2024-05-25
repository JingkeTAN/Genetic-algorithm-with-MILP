%子程序：新种群选择操作, 函数名称存储为selection.m
function [father_1,father_2]=selection(new_path)
%从种群中选择两个个体
%筛选出series为0的个体
new_path = new_path([new_path.series] == 0);
%生成一个随机的整数序列
r = randperm(length(new_path));
%选择前两个作为父代
father_1 = new_path(r(1));
father_2 = new_path(r(2));
end
