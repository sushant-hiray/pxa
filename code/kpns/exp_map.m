function [Data] = exp_map(v,TData)
	assert (abs(sum(v'*TData)) < 1e-2,'perp error');
	assert (abs(1 - norm (v)) < 1e-5, '[exp_map]: v norm error');
	V = v(:,ones(1,size(TData,2)));
	TDataNorms = sqrt(sum(TData.^2,1));
	cosNorms = cos(TDataNorms);
	cosNormsRep = cosNorms(ones(size(TData,1),1),:);
	sinNorms = sin(TDataNorms);
	sinNormsRep = sinNorms(ones(size(TData,1),1),:);
	Data = cosNormsRep.*V + sinNormsRep.*normc(TData)
end