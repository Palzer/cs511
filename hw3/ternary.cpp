/*-----------------------
David Palzer
CSCI 511
February 26th, 2013
------------------------*/
#include <stdio.h>
#include <iostream>
#include <vector>
#include <sstream>
#include <string>
#include <fstream>
#include <complex>
#include <cmath>
#include <cstdlib>
#include <limits>
#include <math.h>
#include <set>
#define _USE_MATH_DEFINES

using namespace std;

complex<double>* readinput(int* size);
void display(complex<double>* a, complex<double>* b, complex<double>* c, int length);
complex<double>* fft(complex<double>* a, int size);
complex<double>* interpol(complex<double>* a,int size);
int cuberoot(int size);

int main(){
	
	int size;
	int mult = 0;
	complex<double>* input = readinput(&size);			//O(n)
	complex<double>* ptval = fft(input,size);
	complex<double>* coeff = interpol(ptval,size);
	int root = cuberoot(size);
	for (int i = 1; i < root; i++){
		mult = i + mult;
	}
	mult = mult - root;
	complex<double> base = size*pow(3,mult);
	for (int i = 0; i < size; i++){
		coeff[i] = coeff[i]*base;
	}
	display(input,ptval,coeff,size);

}

int cuberoot(int size){

	int i = size;
	int root = 0;
	while (i>1){
		i = i/3;
		root++;	
	}
	return root;

}

complex<double>* interpol(complex<double>* a,int size){

	int i;
	
	if (size == 1)
		return (complex<double>*) a; //may have error here
		
	complex<double> wn = polar((double)1, (double)(-2*M_PI/size));
	complex<double> w = 1;
		
	complex<double>* a0 = (complex<double>*) malloc((size/3)*sizeof(complex<double>));
	complex<double>* a1 = (complex<double>*) malloc((size/3)*sizeof(complex<double>));
	complex<double>* a2 = (complex<double>*) malloc((size/3)*sizeof(complex<double>));
	
	i = 0;
	while (i <= size-3){
		//fprintf(stderr,"a0[%i] = a[%i]\n",i/3,i);
		a0[i/3] = a[i];
		i = i + 3;}
	i = 1;
	while (i <= size-2){
		//fprintf(stderr,"a1[%i] = a[%i]\n",i/3,i);
		a1[i/3] = a[i];
		i = i + 3;}
	i = 2;
	while (i <= size-1){
		//fprintf(stderr,"a1[%i] = a[%i]\n",i/3,i);
		a2[i/3] = a[i];
		i = i + 3;}
		
	complex<double>* y0 = interpol(a0,size/3);
	complex<double>* y1 = interpol(a1,size/3);
	complex<double>* y2 = interpol(a2,size/3);
	
	complex<double>* y = (complex<double>*) malloc(size*sizeof(complex<double>));
	//cerr << w << endl << wn << endl;
	complex<double> wx = 1;
	complex<double> wp = 1;
	for (int k = 1; k <= (size/3); k++){ //wn^(n/3)
		wx = wx*wn;
	}
	for (int k = 1; k <= 2*(size/3); k++){ //wn^(2n/3)
		wp = wp*wn;
	}
	complex<double> n = size;
	for (int k = 0; k <= (size/3)-1; k++){
		y[k] = y0[k] + w*y1[k] + w*w*y2[k];
		y[k] = y[k]/n;
		y[k+size/3] = y0[k] + w*wx*y1[k] + (w*wx)*(w*wx)*y2[k];
		y[k+size/3] = y[k+size/3]/n;
		y[k+(2*(size/3))] = y0[k] + w*wp*y1[k] + (w*wp)*(w*wp)*y2[k];
		y[k+(2*(size/3))] = y[k+(2*(size/3))]/n;
		w = w*wn;
	}
	return y;

}

complex<double>* fft(complex<double>* a, int size){

	int i;
	
	if (size == 1)
		return (complex<double>*) a; //may have error here
		
	complex<double> wn = polar((double)1, (double)(2*M_PI/size));
	complex<double> w = 1;
		
	complex<double>* a0 = (complex<double>*) malloc((size/3)*sizeof(complex<double>));
	complex<double>* a1 = (complex<double>*) malloc((size/3)*sizeof(complex<double>));
	complex<double>* a2 = (complex<double>*) malloc((size/3)*sizeof(complex<double>));
	
	i = 0;
	while (i <= size-3){
		//fprintf(stderr,"a0[%i] = a[%i]\n",i/3,i);
		a0[i/3] = a[i];
		i = i + 3;}
	i = 1;
	while (i <= size-2){
		//fprintf(stderr,"a1[%i] = a[%i]\n",i/3,i);
		a1[i/3] = a[i];
		i = i + 3;}
	i = 2;
	while (i <= size-1){
		//fprintf(stderr,"a1[%i] = a[%i]\n",i/3,i);
		a2[i/3] = a[i];
		i = i + 3;}
		
	complex<double>* y0 = fft(a0,size/3);
	complex<double>* y1 = fft(a1,size/3);
	complex<double>* y2 = fft(a2,size/3);
	
	complex<double>* y = (complex<double>*) malloc(size*sizeof(complex<double>));
	//cerr << w << endl << wn << endl;
	complex<double> wx = 1;
	complex<double> wp = 1;
	for (int k = 1; k <= (size/3); k++){ //wn^(n/3)
		wx = wx*wn;
	}
	for (int k = 1; k <= 2*(size/3); k++){ //wn^(2n/3)
		wp = wp*wn;
	}
	for (int k = 0; k <= (size/3)-1; k++){
		y[k] = y0[k] + w*y1[k] + w*w*y2[k];
		y[k+size/3] = y0[k] + w*wx*y1[k] + (w*wx)*(w*wx)*y2[k];
		y[k+(2*(size/3))] = y0[k] + w*wp*y1[k] + (w*wp)*(w*wp)*y2[k];
		w = w*wn;
	}
	return y;
}

complex<double>* readinput(int* size){

	cerr << "reading file.\n";
	complex<double>* b;
	ifstream myfile;
	string line;
	int i = 1;
	int p = 0;
	b = (complex<double>*) malloc (sizeof(complex<double>));
	//myfile.open("ternary243.txt");
	myfile.open("ternary81.txt");
	//myfile.open("ternary27.txt");
	//myfile.open("test9.txt");
	//myfile.open("test3.txt");
	if (myfile.is_open()){
		while (getline(myfile, line)){
			//fprintf(stderr,"checkin array size\n");
			if (i > pow(3,p)){
				//fprintf(stderr,"i = %i, p = %i, 3^p = %f, gotta increase p\n",i,p,pow(3,p));
				p = p + 1;
				b = (complex<double>*) realloc (b,pow(3,p)*sizeof(complex<double>));
				//fprintf(stderr,"successfully realloced to size p = %i, 3^p = %f\n",p,pow(3,p));
			}
			//fprintf(stderr,"getting number\n");
			istringstream in(line);
			in >> b[i-1];
			i = i + 1;
		}		
		myfile.close();
		cerr << "finished ready file.\n";
	}
	else{
		cerr << "Could not open file\n";
	}
	*size = i-1;
	return b;
}

void display(complex<double>* a, complex<double>* b, complex<double>* c, int length){
	fprintf(stderr,"     a        b(real)    b(imag)    c(real)    c(imag)\n");
	fprintf(stderr,"------------------------------------------------------\n");
	for (int i = 1; i <= length; i++){
		fprintf(stderr,"%10.4f %10.4f %10.4f %10.4f %10.4f\n",a[i-1].real(),b[i-1].real(),b[i-1].imag(),c[i-1].real(),c[i-1].imag());
	}
	
}
