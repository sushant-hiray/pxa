function [Out]= kernel_log_map(G,KData,v0)
   % function inputs is the Gram matrix and the data representation in
   % kernel Feature space
 % Data is expressed as a linear combination of the \phi(x_{i})'s which
 % implies data is just a diagonal
 % v is expressed as a linear combination of \phi(x_{i})
%  	\langle a,b\rangle_{F} 
%      = \langle \sum\limits_{i=1}^{N}\alpha_{i}y_{i},\sum\limits_{i=1}^{N}\beta_{j}y_{j} \rangle_{F}\\
%      = \sum\limits_{i=1}^{N}\sum\limits_{j=1}^{N} \alpha_{i}\beta_{j} \langle y_{i}y_{j} \rangle = \sum\limits_{i=1}^{N}\sum\limits_{j=1}^{N} \alpha_{i}\beta_{j} K(x_{i},x_{j}) = D^{2}\\
% 	 a -\langle a,b\rangle_{F}b &=  \sum\limits_{i=1}^{N} (\alpha_{i}-D\beta_{i})y_{i} 
%                                = \sum\limits_{i=1}^{N}\gamma_{i}y_{i}\\
%    \abs{a -\langle a,b\rangle_{F}b}^2 &=  \sum\limits_{i=1}^{N}\sum\limits_{j=1}^{N} \gamma_{i}\gamma{j}K(x_{i},K_{j}) = L^{2}\\
% 	\arccos(\langle a,b \rangle_{F}) &=  \arccos(D)\\
%     log_{a}(b) &= \dfrac{a - \langle a,b\rangle_{F} b}{\abs{a -\langle a,b\rangle_{F}b }_{F}}\arccos(\langle a,b \rangle_{F}) = \dfrac{\sum\limits_{i=1}^{N} \gamma_{i}y_{i}}{L} \arccos(D) = \sum\limits_{i=1}^{N} \dfrac{\gamma_{i}D}{L} y_{i}
    % KData is weights of \phi{x_{i}} for each data point. Weights for each
    % point are in column
    %<v0,Data>
        
    % a-> kData
    % b-> v0
    
    num_points = size(KData,2);
    num_feat  = size(KData,1);
    'v0 is'
    size(v0)
    'kData is'
    size(KData)
    assert(size(v0,1) == num_feat, 'vo not represented correctly in kernel feature space, kernel_lop_map');
    %G = generateGramMatrix(IData);
    D = (KData'*G*v0)';
    % now replicate D for each and every entry
    D = D(ones(num_feat,1),:);
    alphaRep = v0(:,ones(1,num_points));
    Gamma = KData- (D.*alphaRep);
    NormGamma = Gamma'*G*Gamma; % Diagonal of this matrix corresponds to norms
    L = sqrt(diag(NormGamma));
    L = L';
    L = (L> 1E-10).*L + (L<1E-10)*1E-10;
    L = L(ones(num_feat,1),:);
    ACosD = acos(D);
    Out = (Gamma.*(ACosD./L));
end