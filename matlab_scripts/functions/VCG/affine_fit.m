function [n,V,p] = affine_fit(X, plot_flag)
    %Computes the plane that fits best (lest square of the normal distance
    %to the plane) a set of sample points.
    %INPUTS:
    %
    %X: a N by 3 matrix where each line is a sample point
    %
    %OUTPUTS:
    %
    %n : a unit (column) vector normal to the plane
    %V : a 3 by 2 matrix. The columns of V form an orthonormal basis of the
    %plane
    %p : a point belonging to the plane
    %
    %NB: this code actually works in any dimension (2,3,4,...)
    %Author: Adrien Leygue
    %Date: August 30 2013
    
    %the mean of the samples belongs to the plane
    p = mean(X,1);
    
    %The samples are reduced:
    R = bsxfun(@minus,X,p);
    %Computation of the principal directions if the samples cloud
    [V,D] = eig(R'*R);
    %Extract the output from the eigenvectors
    n = V(:,1);
    V = V(:,2:end);
    
    if nargin < 2
        plot_flag = true;
    end
    
    if plot_flag == true
        %plot the two points p_1 and p_2
        plot3(p(1), p(2), p(3),'ro','markersize',15,'markerfacecolor','red');

        %plot the normal vector
        quiver3(p(1), p(2), p(3), n(1)/3, n(2)/3, n(3)/3, 'r', 'linewidth', 2)

        %plot the two adjusted planes
        [X,Y] = meshgrid(linspace(-1,1,3));

        %first plane
        surf(X,Y, - (n(1)/n(3)*X+n(2)/n(3)*Y-dot(n,p)/n(3)),'facecolor','red','facealpha', 0.5);
    end
end