a=imread('sample_image.jpg');
a=rgb2gray(a);
figure, imshow(a), title('Original Image');

cont='y';
while cont == 'y'
   fprintf('\nCHOOSE FILTER\n');
   fprintf('1. Sobel Filter\n');
   fprintf('2. Averaging Filter\n');
   fprintf('3. Laplacian Filter\n');
   choice = input('ENTER YOUR CHOICE : ','s');

   switch choice
     case '1'
         f=fspecial('sobel');
     case '2'
         f=fspecial('average',5);
     case '3'
         f=fspecial('laplacian');
     otherwise
         fprintf('invalid choice'); f='a';
   end
   
   if f ~= 'a'
     w=imfilter(double(a),double(f), 0, 'conv');
     figure, imshow(w,[]), title('Result after applying Spatial Domain Filtering');
     
     p=2*size(a,1);
     q=2*size(a,2);

     p1=fft2(double(a), p, q);
     q1=fft2(double(f), p, q);

     g1=p1.*q1;
      
     z=real(ifftn(g1));

     z=z(1:p/2, 1:q/2);

     figure, imshow(z,[]), title('Result after applying Frequency Domain Filtering');

   end

   cont=input('\nDo you want to continue?? ','s');
end