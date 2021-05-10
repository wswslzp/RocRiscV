// MA: (int, l*m); MB: (int, m*n); Res: (int, l*n)
int GEneralMatrixMul(int **ma, int **mb, int **res, int l, int m, int n)
{
    for(int i = 0; i < l; i++)
    {
        for(int j = 0; j < n; j++)
        {
            res[i][j] = 0;
            for(int ind = 0; ind < l; ind++)
            {
                res[i][j] += ma[i][ind] * mb[ind][j];
            }       
        }
    }
}