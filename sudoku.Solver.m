%-------------------------------------------------------------------------%
%------------------------------Notations----------------------------------%
%-------------------------------------------------------------------------%
%
% This is a function to solve the Sudoku puzzle.
% Usage: 
% - Step_1: Declare X (preferably in the Command Window).
% - Step_2: run "sudoku(X)".
% With:
% - X is a 9x9 matrix representing the sudoku puzzle. 
% - Each blank cell (that needs to be filled) is denoted as "0" 
% (the number "zero").

% You can use the sample puzzles below to test the function or find them
%online (E.g: https://www.websudoku.com/). 

%-------------------------------------------------------------------------%
%-----------------------------Sample Puzzles------------------------------%
%-------------------------------------------------------------------------%
%{
X=[7 0 8 0 0 3 0 4 1;0 6 4 0 0 5 0 0 9;0 0 5 2 0 0 0 0 0;...
   0 0 0 4 3 0 2 5 7;4 0 0 0 1 0 0 0 8;6 5 2 0 7 9 0 0 0;...
   0 0 0 0 0 1 4 0 0;9 0 0 3 0 0 1 8 0;2 4 0 7 0 0 9 0 5]
                                  %---%
X=[6 8 0 0 0 5 3 0 0;0 0 5 0 3 0 0 0 0;1 2 3 0 8 9 6 0 0;...
   0 6 0 5 9 0 0 4 0;0 0 0 1 0 3 0 0 0;0 9 0 0 6 7 0 3 0;...
   0 0 9 3 7 0 5 1 6;0 0 0 0 2 0 8 0 0;0 0 7 6 0 0 0 9 4]
                                  %---%
X=[0 0 4 0 5 6 0 7 8;0 1 0 0 0 4 3 0 5;6 0 5 0 0 0 4 0 0;...
   0 0 0 0 8 0 7 2 0;3 0 7 0 4 0 6 0 1;0 6 8 0 2 0 0 0 0;...
   0 0 3 0 0 0 2 0 9;2 0 1 8 0 0 0 4 0;4 5 0 1 9 0 8 0 0]
                                  %---%
 **Expert level puzzle:
X=[6 0 0 3 0 0 0 0 0;0 1 3 0 6 0 0 0 0; 0 0 0 0 9 0 0 8 0;...
   4 0 0 0 0 5 0 0 0;0 6 0 0 0 4 0 9 0; 0 3 0 0 0 0 7 0 0;...
   8 0 0 0 0 0 2 5 0;0 0 0 8 0 1 0 0 9; 0 4 0 9 0 0 0 0 1]
%}

%-------------------------------------------------------------------------%
%--------------------------------SUDOKU-----------------------------------%
%-------------------------------------------------------------------------%
%
function[X] = sudoku(X)
%This is where the main function is 

[cand,sgleCELL,emptCELL] = candidate(X); %find the candidates

%-------------------------------------------------------------------------%
%Finding and filling out all the singletons until there are non left
while ~isempty(sgleCELL)
    X(sgleCELL)=cand{sgleCELL}; %fill in the singletons
    [cand,sgleCELL,emptCELL] = candidate(X); %find the candidates again
end

%-------------------------------------------------------------------------%
%Return when there's an invalid cell (no candidates)
if ~isempty(emptCELL)
    return
end
    
%-------------------------------------------------------------------------%    
%Recursive Backtracking
if any(X(:)==0) 
    Y=X; %save current value of X to Y so we can backtrack to when there appears to be an invalid cell (no candidates) 
    empt=find(X(:)==0,1); %find the index of the 1st unfilled cell
    for i=[cand{empt}] %creating a loop to test all possible values (the candidates) of the unfilled cell 
       X=Y; 
       X(empt)=i;  %inserting a possible value to the 1st unfilled cell found
       X=sudoku(X); %calling the fuction itself (recursive call) 
       if all(X(:)>0)
          return 
       end 
     end 
end 

end%sudoku()

%-------------------------------------------------------------------------%
%----------------------------Local Functions------------------------------%
%-------------------------------------------------------------------------%
%
function[cand,sgleCELL,emptCELL] = candidate(X)
%This is the function to find the candidates

XBox1=[X(1,1);X(1,2);X(1,3);X(2,1);X(2,2);X(2,3);X(3,1);X(3,2);X(3,3)]; %3x3 block No.1
XBox2=[X(4,1);X(4,2);X(4,3);X(5,1);X(5,2);X(5,3);X(6,1);X(6,2);X(6,3)]; %3x3 block No.2
XBox3=[X(7,1);X(7,2);X(7,3);X(8,1);X(8,2);X(8,3);X(9,1);X(9,2);X(9,3)]; %3x3 block No.3
XBox4=[X(1,4);X(1,5);X(1,6);X(2,4);X(2,5);X(2,6);X(3,4);X(3,5);X(3,6)]; %3x3 block No.4
XBox5=[X(4,4);X(4,5);X(4,6);X(5,4);X(5,5);X(5,6);X(6,4);X(6,5);X(6,6)]; %3x3 block No.5
XBox6=[X(7,4);X(7,5);X(7,6);X(8,4);X(8,5);X(8,6);X(9,4);X(9,5);X(9,6)]; %3x3 block No.6
XBox7=[X(1,7);X(1,8);X(1,9);X(2,7);X(2,8);X(2,9);X(3,7);X(3,8);X(3,9)]; %3x3 block No.7 
XBox8=[X(4,7);X(4,8);X(4,9);X(5,7);X(5,8);X(5,9);X(6,7);X(6,8);X(6,9)]; %3x3 block No.8 
XBox9=[X(7,7);X(7,8);X(7,9);X(8,7);X(8,8);X(8,9);X(9,7);X(9,8);X(9,9)]; %3x3 block No.9

cand=cell(9,9); %creating a 9x9 cell array to store the candidates
for j=1:9
    for i=1:9
        if X(i,j)==0 
            z=1:9; %creating an array of 9 candidates (no conditions yet)
            z(nonzeros(X(i,:)))=0; %eliminating candidates according to the column
            z(nonzeros(X(:,j)))=0; %eliminating candidates according to the row
            if (i>=1) && (i<=3) && (j>=1) && (j<=3)
                z(nonzeros(XBox1))=0; %eliminating candidates according to the containing 3x3 block
            elseif (i>=4) && (i<=6) && (j>=1) && (j<=3)
                z(nonzeros(XBox2))=0;
            elseif (i>=7) && (i<=9) && (j>=1) && (j<=3)
                z(nonzeros(XBox3))=0;
            elseif (i>=1) && (i<=3) && (j>=4) && (j<=6)
                z(nonzeros(XBox4))=0;
            elseif (i>=4) && (i<=6) && (j>=4) && (j<=6)
                z(nonzeros(XBox5))=0;
            elseif (i>=7) && (i<=9) && (j>=4) && (j<=6)
                z(nonzeros(XBox6))=0;
            elseif (i>=1) && (i<=3) && (j>=7) && (j<=9)
                z(nonzeros(XBox7))=0;
            elseif (i>=4) && (i<=6) && (j>=7) && (j<=9)
                z(nonzeros(XBox8))=0;
            elseif (i>=7) && (i<=9) && (j>=7) && (j<=9)
                z(nonzeros(XBox9))=0;
            end
            cand{i,j}=nonzeros(z)'; %storing the final candidates into the cell array
        end
    end
end

N=cellfun(@length,cand); %number of candidates in each cell
sgleCELL=find(X==0 & N==1,1); %find the 1st singleton cell
emptCELL=find(X==0 & N==0,1); %find the 1st empty cell (no candidates)
end%candidate(X)