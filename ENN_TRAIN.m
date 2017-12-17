clc;
clear;

%Data Init

categoryNum = 3;%������Ŀ
TrainDataType1 = xlsread('data.xlsx',1,'b2:j11');%��һ����������
TrainDataType2 = xlsread('data.xlsx',1,'b12:j22');%�ڶ�����������
TrainDataType3 = xlsread('data.xlsx',1,'b23:j33');%��������������
TrainData = [TrainDataType1;TrainDataType2;TrainDataType3];
Type = xlsread('data.xlsx',1,'k2:k33');%������Ӧ����������

theta = 0.01;
sampleNum = size(Type,1);


WL = [min(TrainDataType1);min(TrainDataType2);min(TrainDataType3)];
WH = [max(TrainDataType1);max(TrainDataType2);max(TrainDataType3)];

Z = (WL+WH)/2;
Y = (WH - WL)/2;

% ������ؾ���
ED = zeros(sampleNum,3);
ET_plot=[];
calTimes = 1;
while(1)
    ET = 0;
    Nm = 0;
    Np = sampleNum;
    for i = 1:sampleNum
        Y = (WH - WL)/2;
        for k = 1:categoryNum
        ED_temp = (abs(TrainData(i,:) - Z(k,:)) - Y(k,:))./Y(k,:) + 1.0;
        ED(i,k) = sum(ED_temp);
        end
        [minED,K_temp] = min(ED(i,:));
        K_temp;
        Type_temp = Type(i);
        if K_temp == Type(i)
            continue;
        else
            K_temp_problem = i;
            Nm = Nm +1;
            disp('����ǰ');
            WL
            WH
            Z
            WL(Type(i),:) = WL(Type(i),:)+theta*(TrainData(i,:)-Z(Type(i),:));
            WH(Type(i),:) = WH(Type(i),:)+theta*(TrainData(i,:)-Z(Type(i),:));
            WL(K_temp,:) = WL(K_temp,:)-theta*(TrainData(i,:)-Z(K_temp,:));
            WH(K_temp,:) = WH(K_temp,:)-theta*(TrainData(i,:)-Z(K_temp,:));

            Z(Type(i),:) = Z(Type(i),:) + theta*(TrainData(i,:)-Z(Type(i),:));
            Z(K_temp,:) = Z(K_temp,:) - theta*(TrainData(i,:)-Z(K_temp,:));
            disp('������');
            WL
            WH
            Z
        end
    end
    ET = Nm/Np
    ET_plot = [ET_plot,ET];
    if(ET<0.02)
        break;
    end
    calTimes = calTimes + 1;
end
calTimes


%used for test
% test = (abs(TrainDataType1(1,:) - Z1') - Y1')./Y1'+1.0
% test2 = (abs(TrainDataType1(1,:) - Z(1,:)) - Y(1,:))./Y(1,:)+1.0

