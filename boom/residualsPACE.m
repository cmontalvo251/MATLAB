function residualsPACE(fileActual,filePACE,units,conv,save)
%%Compute Cost Depending On 2 text files
close all
%%%%%%%%%%%%%%%%%FLAGS%%%%%%%%%%%%%%%%%%%

RESTYPE = 4; %1 = everything,2 = forces/moments,states
             %3 = categories,4 = full split
ERROR = 0; %0 for absolute	     
%PACE = 1;

Actual = dlmread(fileActual);
PACE = dlmread(filePACE);

if nargin > 2
  %other = dlmread(otherfile);
  if units == 0
      %English
      l = 'ft';
      f = 'lbf';
  elseif units == 1
      l = 'm';
      f = 'N';
  end
  if conv == 3.28
      lconv = 3.28;
      fconv = 4.44;
  elseif conv == 1
      lconv = 1;
      fconv = 1;
  end  
end

%Actual = dlmread('fileconverted.in');
%Actual = dlmread('ANF_m2_BOOM.in');
%Actual =  dlmread('sixdof_m3_long_prodas.dat');
%Actual = dlmread('sixdof_m11_CFD_ZUP_9667_long.dat');
%Actual = dlmread('sixdof_m11_Boom_ZDOWN_9667.in');
%Actual = dlmread('sixdof_m11_Boom_ZDOWN_9667.in');
%Actual = dlmread('HTK_Full_Actual.IN');
%Other = dlmread('HTK_Full_DiffX0.OUT');
%Actual = dlmread('sahu_proj.in');
%PLT = dlmread('HTK_PACE_PLT.OUT');
%Actual = dlmread('Spinner_PACE_result.out');
%PACE = dlmread('Spinner_PACE_result_neg.out');
%PACE = dlmread('HTK_PACE_Result.OUT');
%PACE = dlmread('Sahu_PACE_result.out');
%PACE = dlmread('ANF_PACE_result.out');
%Actual = dlmread('Spinner_m11_Boom_ZDOWN_9667_long.in');
%PACE = dlmread('original_Boom_ZDOWN.in');
%Actual = dlmread('original_Boom_ZDOWN.in');
%Actual = dlmread('cnpa3_added.in');
%Actual = dlmread('nonlinear_Boom_ZDOWN.in');
%PACE = dlmread('nonlinear_PACE_results.out');
%PACE = dlmread('nonlinear_Boom_ZDOWN.in');

[r,c] = size(Actual);
TimeA = Actual(:,1);
TimeP = PACE(:,1);
%PACE = Actual;
cost = 0;
if RESTYPE == 4
  disp('Full Split')
  units = {['x(',l,')'],['y(',l,')'],['z(',l,')'],'\phi(deg)','\theta(deg)','\psi(deg)',['u(',l,'/s)'],['v(',l,'/s)'],['w(',l,'/s)'],'p(rad/s)','q(rad/s)','r(rad/s)',['Fx(',f,')'],['Fy(',f,')'],['Fz(',f,')'],['L(',f,'-',l,')'],['M(',f,'-',l,')'],['N(',f,'-',l,')']};
  for ii = 2:19  
    h1 = plottool(1,units{ii-1},12,'Time(sec)',units{ii-1});
    if ii <= 4 || (ii >= 8 && ii <= 10)
        factor = 1/lconv;
    elseif ii > 13
        factor = fconv/lconv;
    elseif ii > 4 && ii < 8
      factor = 180/pi;
    else
      factor = 1;
    end 
%     if nargin > 2
%       p1=plot(Time,Actual(:,ii).*factor,'b-','LineWidth',2);
%       p2=plot(Time,PACE(:,ii).*factor,'r-','LineWidth',2);
%       p1 = p1(1);  p2 = p2(1);
%       p3=plot(Time,other(:,ii).*factor,'g-','LineWidth',2);
%       p3 = p3(1);
%       legend([p1 p2 p3],'File1','File2','File3')
%     else
      %cost = cost + sum((Actual(:,ii) - PACE(:,ii)).^2);
      if ii == 5
          p1=plot(TimeA,unwrap(Actual(:,ii)).*factor,'k-','LineWidth',2);
      else
          p1=plot(TimeA,Actual(:,ii).*factor,'k-','LineWidth',2);
      end
      p2=plot(TimeP,PACE(:,ii).*factor,'k--','LineWidth',2);
      p1 = p1(1);  p2 = p2(1);
      legend([p1 p2],'CFD Data','PACE Results')
      %xlim([0 6.5])
      if save
	filename = units{ii-1};
	filename(filename=='/')=[];
	filename(filename=='\')=[]
	if ii < 10
	  z = '000';
	else
	  z = '00';
	end
	saveas(gca,[z,num2str(ii),filename,'.png']);
      end
    %end
  end
  %%%%Plot Extras
  uactual = Actual(:,8);
  vactual = Actual(:,9);
  wactual = Actual(:,10);
  uPACE = PACE(:,8);
  vPACE = PACE(:,9);
  wPACE = PACE(:,10);
  %Total velocity
  VtotalA = sqrt(uactual.^2 + vactual.^2 + wactual.^2);
  VtotalP = sqrt(uPACE.^2 + vPACE.^2 + wPACE.^2);
  h1 =plottool(1,'Vtotal',12,'Time(sec)','V(ft/s)');
  plot(TimeA,VtotalA,'k-','LineWidth',2)
  plot(TimeP,VtotalP,'k--','LineWidth',2)
  legend('CFD Data','PACE Results')
  if save
    saveas(gca,['0020Vtotal.png']);
  end
  %%Angle of attack and beta
  alfaA = atan2(wactual,uactual).*180/pi;
  alfaP = atan2(wPACE,uPACE).*180/pi;
  betaA = atan2(vactual,uactual).*180/pi;
  betaP = atan2(vPACE,uPACE).*180/pi;
  alfabarA = atan2(sqrt(vactual.^2+wactual.^2),uactual).*180/pi;
  alfabarP = atan2(sqrt(vPACE.^2+wPACE.^2),uPACE).*180/pi;
  h1 = plottool(1,'Alfa',12,'Time(sec)','Alfa(deg)');
  plot(TimeA,alfaA,'k-','LineWidth',2)
  plot(TimeP,alfaP,'k--','LineWidth',2)
  legend('CFD Data','PACE Results')
  if save
    saveas(gca,['0021Alfa.png']);
  end
  h1 = plottool(1,'Beta',12,'Time(sec)','Beta(deg)');
  plot(TimeA,betaA,'k-','LineWidth',2)
  plot(TimeP,betaP,'k--','LineWidth',2)
  legend('CFD Data','PACE Results')
  if save
    saveas(gca,['0022beta.png']);
  end
  h1 = plottool(1,'Total Angle of Attack',12,'Time(sec)','Alfabar(deg)');
  plot(TimeA,alfabarA,'k-','LineWidth',2)
  plot(TimeP,alfabarP,'k--','LineWidth',2)
  legend('CFD Data','PACE Results')
  if save
    saveas(gca,['0023Alfabar.png']);
  end
end


cost

%system('convert *.png Results_wo_2.0.pdf');
%system('rm *.png');

%%Extract CX0 and CX2
RHO = 0.00238;
vinf = VtotalA;
D = 0.0984;
vaerocg = vactual;
waerocg = wactual;
epsaoa = sqrt(vaerocg.^2+waerocg.^2)./vinf;
qa = 3.141592653*RHO*vinf.^2*D^2/8
%%Without
cx0 = 0.4503;
cx2 = 1;
%%With
%cx0 = 0.4968;
%cx2 = 3;
XBODYFORCE = -qa.*(cx0+cx2*epsaoa.^2);
plottool(1,'XBODYFORCE',12,'Time(s)','Fx(lbf)');
plot(TimeA,Actual(:,14),'b-','LineWidth',2)
plot(TimeA,XBODYFORCE,'r-','LineWidth',2)
%Fit using Actual(:,14)
FxCFD = Actual(:,14);
cxtotal = FxCFD./-qa;
X = cxtotal;
H = [ones(length(epsaoa),1),epsaoa];
theta = inv(H'*H)*H'*X;
cx0 = theta(1)
cx2 = theta(2)
XBODYFORCE = -qa.*(cx0+cx2*epsaoa.^2);
plot(TimeA,XBODYFORCE,'g-','LineWidth',2)

plottool(1,'CXtotal',12,'Alfabar(rad)','cxtotal');
plot(epsaoa.*180/pi,cxtotal)

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
