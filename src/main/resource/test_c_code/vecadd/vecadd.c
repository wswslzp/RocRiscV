int vecadd(int *va, int *vb, int *vc, int l)
{
    for(int i = 0; i < l; i++)
    {
        vc[i] = va[i] + vb[i];
    }
    return 0;
}

