using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MendlebrotController : MonoBehaviour
{
    public Material mat;
    public float zoom = 2;

    private void Start()
    {
        
    }
    private void Update()
    {
        float offsetX = .5f, offsetY= .5f;

        offsetX += Input.GetAxis("Horizontal");
        offsetY += Input.GetAxis("Vertical");
        if(Input.GetKey(KeyCode.Space))
            zoom *= .99f;
        mat.SetVector("_Offset", new Vector4(offsetX, offsetY, 0, 0));
        mat.SetFloat("_Zoom", zoom);


    }
}
