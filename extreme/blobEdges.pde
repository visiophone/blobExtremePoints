// ==================================================
// drawBlobsAndEdges()
// ==================================================

// vector that stores the centroid
Vec2D centroid = new Vec2D(0, 0);
int nrPoints=0;

void drawBlobsAndEdges(boolean drawBlobs, boolean drawEdges)
{

  noFill();
  //getting blob
  Blob b;
  // getting blob points
  EdgeVertex eA, eB;
  for (int n=0 ; n<theBlobDetection.getBlobNb() ; n++)
  {
    // starting blob
    b=theBlobDetection.getBlob(n);

    // I am just loocking for 1 big blob. the first blob, Bigger that 00.1)

    if (b!=null && n==0 && (b.w*b.h)>0.01)
    {

      //Calculate centroid
      //the blob coordinates came in normalized numbers. multply the the screen W, H to get the real size
      centroid.x= (b.x)*width;
      centroid.y= (b.y)*height;  
      noFill();

      // drawing the contour/silluete
      if (drawEdges)
      {
        strokeWeight(1);
        stroke(100);

        // storing the silluete points to feed the ConvexHull function
        float[][] points = new float[b.getEdgeNb()][2];

        // Looping all the silluete points
        for (int m=0;m<b.getEdgeNb();m++)
        {

          eA = b.getEdgeVertexA(m);
          eB = b.getEdgeVertexB(m);

          // array with the points, to feed the hull function, below.
          // I want to reduce the number of points to use i the convex Hull. So I use a "step" to jump points.
          if (m%stepPoints==0) {
            points[nrPoints][0]=eA.x*width;
            points[nrPoints][1]=eA.y*height;
            //println(m+" "+points[nrPoints][0]+"-"+points[nrPoints][1]);
            nrPoints++;
          }
          //drawing line around the silluete
          if (eA !=null && eB !=null && cvBlob)
            line(
            eA.x*width, eA.y*height, 
            eB.x*width, eB.y*height
              );
        }


        float[][] points2 = new float[nrPoints][2];
        for (int i=0;i<nrPoints;i++) {     
          points2[i][0]=points[i][0];
          points2[i][1]=points[i][1];
        }

        nrPoints=0;

        // convex Hull to find end points
        Hull myHull = new Hull( points2 ); 
        MPolygon myRegion = myHull.getRegion();
        stroke(255);
        //draw line around convex shape
        if (cvExtShape)  myRegion.draw(this);
        int[] extrema = myHull.getExtrema();
        fill(255);
        noStroke(); 
        //draw end points
        if (cvExtShape) {
          for (int i=0;i<extrema.length;i++) {
            ellipse(points[extrema[i]][0], points[extrema[i]][1], 10, 10);
          }
        }
      }

      // Drawing centroid and box around the blob
      if (drawBlobs && cvBlob)
      {
        strokeWeight(1);
        stroke(50);
        noFill();
        rect(
        b.xMin*width, b.yMin*height, 
        b.w*width, b.h*height
          );
        noStroke();
        fill(240);
        ellipse(b.xMin*width, b.yMin*height, 5, 5);
        ellipse(b.xMax*width, b.yMin*height, 5, 5);
        ellipse(centroid.x, centroid.y, 10, 10);
      }
    }
  }
}

