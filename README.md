##### THE CULTURAL EVOLUTION OF COLLECTIVE PROPERTY RIGHTS FOR NATURAL RESOURCE GOVERNANCE ##############

Welcome!

Contained within this repo is everything needed to reproduce the analysis presented in the Nature Sustainability Paper.

A few notes.

The MAKE.jl file will run everything necessary for you to reproduce the results from the model. 
You should make sure that you set the working directory to the folder that will house '/cpr_public/'
You can speed up all models by setting nprocs() in the MAKE file just after loading the distributed package. I use 32 cores. 
The sweeps contained in the SI are BIG. I used 100 cores, and they generated 100s of gigs of data.  
Thus, I highly recommend that you use an appropriate cluster.

A few more notes on abm_public.
You will note that the argument is LONG.
That is because there are many options that the user can fine-tune.
I have done my best to document everything, but please explore the code independently.
Some features are not finished, such as increasing ngoods > 2, but I have done my best to alert the user to these options. Keep tuned, as this model is an ever-growing piece of work. 

The MAKE.R file is sufficient for reproducing the empirical analysis found in the SI.
Again, please set your working directory as appropriate.

I wish you the best of luck, and have fun. 

Please feel free to contact me with any questions @ jeffreya@gmail.com

Best wishes

Jeffrey Andrews
