function [rotM] = rot(v1,v2)
	%v1 = destination
	%v2 = source
	theta = acos(v2'*v1);
    c = v2 - v1*(v1'*v2);
    c = c / max(norm(c), 1e-4);
    A = v1*c' - c*v1';
    %'skew symmetric';
    rotM = expm(theta*A);
end