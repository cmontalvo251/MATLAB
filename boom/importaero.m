function aero = importaero(aerofile,flag)
if strcmp(flag,'MB')
  fid = fopen(aerofile);
  try
    dummy = fgetl(fid);
  catch
    error(['File Not Found: ',aerofile])
  end
  next = fgetl(fid);
  aero.D = str2num(next(1:find(next=='!')-1));
  next = fgetl(fid);
  aero.SLCG = str2num(next(1:find(next=='!')-1));
  next = fgetl(fid);
  aero.BLCG = str2num(next(1:find(next=='!')-1));
  next = fgetl(fid);
  aero.WLCG = str2num(next(1:find(next=='!')-1));
  next = fgetl(fid);
  aero.MNPTS = str2num(next(1:find(next=='!')-1));
  for ii = 1:aero.MNPTS
    next = fgetl(fid);
    try
      aero.TOMACH(ii) = str2num(next(1:find(next=='!')-1));
    catch
      aero.TOMACH(ii) = str2num(next);
    end
  end
  for ii = 1:aero.MNPTS
    next = fgetl(fid);
    try
      aero.TOCX0(ii) = str2num(next(1:find(next=='!')-1));
    catch
      aero.TOCX0(ii) = str2num(next);
    end
  end
  for ii = 1:aero.MNPTS
    next = fgetl(fid);
    try
      aero.TOCX2(ii) = str2num(next(1:find(next=='!')-1));
    catch
      aero.TOCX2(ii) = str2num(next);
    end
  end
  for ii = 1:aero.MNPTS
    next = fgetl(fid);
    try
      aero.TOCY0(ii) = str2num(next(1:find(next=='!')-1));
    catch
      aero.TOCY0(ii) = str2num(next);
    end
  end
  for ii = 1:aero.MNPTS
    next = fgetl(fid);
    try
      aero.TOCZ0(ii) = str2num(next(1:find(next=='!')-1));
    catch
      aero.TOCZ0(ii) = str2num(next);
    end
  end
  for ii = 1:aero.MNPTS
    next = fgetl(fid);
    try
      aero.TOCNA1(ii) = str2num(next(1:find(next=='!')-1));
    catch
      aero.TOCNA1(ii) = str2num(next);
    end
  end
  for ii = 1:aero.MNPTS
    next = fgetl(fid);
    try
      aero.TOCNA3(ii) = str2num(next(1:find(next=='!')-1));
    catch
      aero.TOCNA3(ii) = str2num(next);
    end
  end
  for ii = 1:aero.MNPTS
    next = fgetl(fid);
    try
      aero.TOCYPA1(ii) = str2num(next(1:find(next=='!')-1));
    catch
      aero.TOCYPA1(ii) = str2num(next);
    end
  end
  for ii = 1:aero.MNPTS
    next = fgetl(fid);
    try
      aero.TOCYPA3(ii) = str2num(next(1:find(next=='!')-1));
    catch
      aero.TOCYPA3(ii) = str2num(next);
    end
  end
  for ii = 1:aero.MNPTS
    next = fgetl(fid);
    try
      aero.TOCL0(ii) = str2num(next(1:find(next=='!')-1));
    catch
      aero.TOCL0(ii) = str2num(next);
    end
  end
  for ii = 1:aero.MNPTS
    next = fgetl(fid);
    try
      aero.TOCM0(ii) = str2num(next(1:find(next=='!')-1));
    catch
      aero.TOCM0(ii) = str2num(next);
    end
  end
  for ii = 1:aero.MNPTS
    next = fgetl(fid);
    try
      aero.TOCN0(ii) = str2num(next(1:find(next=='!')-1));
    catch
      aero.TOCN0(ii) = str2num(next);
    end
  end
  for ii = 1:aero.MNPTS
    next = fgetl(fid);
    try
      aero.TOCLP(ii) = str2num(next(1:find(next=='!')-1));
    catch
      aero.TOCLP(ii) = str2num(next);
    end
  end
  for ii = 1:aero.MNPTS
    next = fgetl(fid);
    try
      aero.TOCMA1(ii) = str2num(next(1:find(next=='!')-1));
    catch
      aero.TOCMA1(ii) = str2num(next);
    end
  end
  for ii = 1:aero.MNPTS
    next = fgetl(fid);
    try
      aero.TOCMA3(ii) = str2num(next(1:find(next=='!')-1));
    catch
      aero.TOCMA3(ii) = str2num(next);
    end
  end
  for ii = 1:aero.MNPTS
    next = fgetl(fid);
    try
      aero.TOCMQ1(ii) = str2num(next(1:find(next=='!')-1));
    catch
      aero.TOCMQ1(ii) = str2num(next);
    end
  end
  for ii = 1:aero.MNPTS
    next = fgetl(fid);
    try
    aero.TOCMQ3(ii) = str2num(next(1:find(next=='!')-1));
    catch
    aero.TOCMQ3(ii) = str2num(next);
    end
  end
  for ii = 1:aero.MNPTS
    next = fgetl(fid);
    try
      aero.TOCNPA1(ii) = str2num(next(1:find(next=='!')-1));
    catch
      aero.TOCNPA1(ii) = str2num(next);
    end
  end
  for ii = 1:aero.MNPTS
    next = fgetl(fid);
    try
      aero.TOCNPA3(ii) = str2num(next(1:find(next=='!')-1));
    catch
      aero.TOCNPA3(ii) = str2num(next);
    end
  end
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
