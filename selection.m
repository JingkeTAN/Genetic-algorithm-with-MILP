%�ӳ�������Ⱥѡ�����, �������ƴ洢Ϊselection.m
function [father_1,father_2]=selection(new_path)
%����Ⱥ��ѡ����������
%ɸѡ��seriesΪ0�ĸ���
new_path = new_path([new_path.series] == 0);
%����һ���������������
r = randperm(length(new_path));
%ѡ��ǰ������Ϊ����
father_1 = new_path(r(1));
father_2 = new_path(r(2));
end
