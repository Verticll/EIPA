nx = 50;
ny = 50;
ni = nx*ny;

V = zeros(nx,ny);
G = sparse(nx*ny,nx*ny);


%Create V 
% SidesToZero = 1;
% for k  = 1:ni
%     for i = 1:nx
%         for j = 1:ny...
%         
%         if (i == j)
%         V(i,j) = 1;
%         elseif (i == 1)%top
%         V(i,j) = 0;
%         elseif (i == nx)%bottom
%         V(i,j) = 0;
%         elseif (j == 1)%left
%         V(i,j) = 0;
%         elseif (j == ny)%right
%         V(i,j) = 0;
%         else
%         V(i,j) = (V(i+1,j)+V(i-1,j)+V(i,j+1)+V(i,j-1))/4;
%         end
% 
%            % if mod(k,50) == 0 && i == 1 && j == 1
%            %     surf(V')
%            %     pause(0.05)
%            % end
%         end
%     end
% end

surf(V')
%                nxm = V(i-1,j);
%                nxp = V(i+1,j);
%               nym = V(i,j-1);
%               nyp = V(i,j+1);
%               (nxp - 2*n + nxm)/del2 + nyp - 2 * n + nya

%Create G
     for i = 1:ny
         for j = 1:nx...
                 n = j + (i - 1) * ny;

             if i == 1 || j == 1 || i == 2500 || j == 2500 
                 G(n,n) = -4;
             elseif i == j
                 G(n,n) = -4;
             else
                 G(n,n) = -3;
                 G(n,n-1) = 4;
                 G(n-1,n) = 4;
             end
         end
     end

figure('name','Matrix')
spy(G)

nmodes = 9;
[E,D] = eigs(G,nmodes,'SM');

figure('name', 'EigenValues')
plot(diag(D),'*');

np = ceil(sqrt(nmodes));
figure('name','Moedes')
for k = 1:nmodes
    M = E(:,k);
    for i = 1:nx
        for j = 1:ny
            n = i + (j-1)*nx;
            V(i,j) = M(n);
        end
        subplot(np,np,k), surf(V,'LineStyle','none')
        title(['EV = ' num2str(D(k,k))])
    end
end
