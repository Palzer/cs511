function [] =  lup ()
	fid = fopen('compact.txt');
	B = fscanf(fid,'%f %f %f', [3 inf]);
	fclose(fid);
	B = B';
	[m,n] = size(B);
	A = zeros(m,4);
	for i=1:m,
		A(i,[1:3]) = B(i,:);
	end
	
	AA = expandMatrix(A);	
	[p L U] = book_decomp(A);	
	P = expandPerm(p')
	[LL UU] = expand(L,U);	
	L
	U	
	P*AA	
	LL*UU

function [LL UU] = expand(L,U)
	[m,n] = size(L);
	m = (m+1)/2;
	LL = zeros(m);
	UU = zeros(m);
	for i=1:m*2-1,
		LL(L(i,1),L(i,2)) = L(i,3);
	end
	for i=1:m*3-3,
		UU(U(i,1),U(i,2)) = U(i,3);
	end

function [p L U] = book_decomp(A)
	[m,n] = size(A);	%find size of A
	p = 1:m;
	swap = false;
	if A(1,2) < A(2,1)
		tmp = A(1,2);
		A(1,2) = A(2,1);
		A(2,1) = tmp;
		tmp = A(1,3);
		A(1,3) = A(2,2);
		A(2,2) = tmp;
		tmp = A(1,4);
		A(1,4) = A(2,3);
		A(2,3) = tmp;
		swap = true;
		%printf('we swapped at depth %i\n',m);
	end
	if swap == true
			tmp = p(1);
			p(1) = p(2);
			p(2) = tmp;
			%fprintf('swapped rows %i and %i\n',1,2);
		end
	if m == 2
		%printf('SIZE TWO: BASE CASE\n');
		%printf('final reduction\n');
		A(2,1) = A(2,1)/A(1,2);
		A(2,2) = A(2,2) - A(2,1)*A(1,3);
		%A
	else		
		%A
		A(2,1) = A(2,1)/A(1,2);
		A(2,2) = A(2,2) - A(2,1)*A(1,3);
		A(2,3) = A(2,3) - A(2,1)*A(1,4);
		%printf('just reduced\n');
		%printf('recursing!\n');
		[p L U] = ex_decomp(A,2,m,p);
		%printf('backup!\n');
	end	
	
function [p L U] = ex_decomp(A,n,m,p)
	swap = false;
	if A(n,2) < A(n+1,1)
		tmp = A(n,2);
		A(n,2) = A(n+1,1);
		A(n+1,1) = tmp;
		tmp = A(n,3);
		A(n,3) = A(n+1,2);
		A(n+1,2) = tmp;
		tmp = A(n,4);
		A(n,4) = A(n+1,3);
		A(n+1,3) = tmp;
		swap = true;
		%printf('we swapped at depth %i\n',m);
	end
	if swap == true
			tmp = p(n);
			p(n) = p(n+1);
			p(n+1) = tmp;
			%fprintf('swapped rows %i and %i\n',n,n+1);
		end
	if m-n == 1
		%printf('SIZE TWO: BASE CASE\n');
		%printf('final reduction\n');
		A(n+1,1) = A(n+1,1)/A(n,2);
		A(n+1,2) = A(n+1,2) - A(n+1,1)*A(n,3);
		L = initializeL(m);
		for i=m+1:m*2-1,
			L(i,1) = m;
			L(i,2) = i-m;
			L(i,3) = A(i-m+1,1);
			if p(i-m+1) == i-m+1
				L(i,1) = i-m+1;
			end
		end
		U = zeros(m*3-3,3);
		cnt = 0;
		for i=1:m-2,
			if i == 1
				U(i+cnt,1) = i;
				U(i+cnt,2) = i;
				U(i+cnt,3) = A(i,2);
				cnt = cnt + 1;
				U(i+cnt,1) = i;
				U(i+cnt,2) = i+1;
				U(i+cnt,3) = A(i,3);
				cnt = cnt + 1;
				U(i+cnt,1) = i;
				U(i+cnt,2) = i+2;
				U(i+cnt,3) = A(i,4);
			else
				U(i+cnt,1) = i;
				U(i+cnt,2) = i;
				U(i+cnt,3) = A(i,2);
				cnt = cnt + 1;
				U(i+cnt,1) = i;
				U(i+cnt,2) = i+1;
				U(i+cnt,3) = A(i,3);
				cnt = cnt + 1;
				U(i+cnt,1) = i;
				U(i+cnt,2) = i+2;
				U(i+cnt,3) = A(i,4);
			end
		end
		U(m-1+cnt,1) = m-1;
		U(m-1+cnt,2) = m-1;
		U(m-1+cnt,3) = A(m-1,2);
		cnt = cnt + 1;
		U(m-1+cnt,1) = m-1;
		U(m-1+cnt,2) = m-1+1;
		U(m-1+cnt,3) = A(m-1,3);
		U(m+cnt,1) = m;
		U(m+cnt,2) = m;
		U(m+cnt,3) = A(m,2);
			
	else		
		%printf('reducing\n');
		A(n+1,1) = A(n+1,1)/A(n,2);
		A(n+1,2) = A(n+1,2) - A(n+1,1)*A(n,3);
		A(n+1,3) = A(n+1,3) - A(n+1,1)*A(n,4);
		%printf('just reduced\n');
		%printf('recursing!\n');
		[p L U] = ex_decomp(A,n+1,m,p);
		%printf('backup! %i\n',n);
	end	

function [L] = initializeL(m)
	L = zeros(m*2-1,3);
	for i=1:m,
		L(i,1) = i;
		L(i,2) = i;
		L(i,3) = 1;
	end
	
function [X] = expandMatrix(A)
	[m,n] = size(A);
	X = zeros(m,m);
	for i=1:m,
		if i == 1
			X(i,i) = A(i,2);
			X(i,i+1) = A(i,3);
			X(i,i+2) = A(i,4);
		elseif i != m
			X(i,i-1) = A(i,1);
			X(i,i) = A(i,2);
			X(i,i+1) = A(i,3);
		else
			X(i,i-1) = A(i,1);
			X(i,i) = A(i,2);
		end
	end

function [P] = expandPerm(p)
	[m,n] = size(p);
	
	P = zeros(m);
	for i=1:m,
		P(i,p(i)) = 1;
	end		
