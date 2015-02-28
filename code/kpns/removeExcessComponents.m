function v = removeExcessComponents(inpV,V)
	v = inpV;
	for i=1:size(V,2)
		temp = V(:,i);
		v = inpV - (inpV'*temp)*temp/sqrt(temp'*temp);
		v = v/sqrt(v'*v);
	end
end