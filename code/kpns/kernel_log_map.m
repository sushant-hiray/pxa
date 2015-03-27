function  kernel_log_map(Data,v0)
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
    % Data is x_i's
    %<v0,Data>
    num_points = size(Data,2);
    assert(size(v0,1) == num_points, 'vo not represented correctly in kernel feature space, kernel_lop_map');
    num_feat  = size(Data,1);
    repData = eye(num_points,num_points);
    G = generateGramMatrix(Data);
    alpha_rep = v0(:,ones(1,num_points));
    repData = G.*alpha_rep;
    repData = sqrt(sum(repData,1));
    Gamma = alpha_rep - D*eye(num_points,num_points);
    
    
end