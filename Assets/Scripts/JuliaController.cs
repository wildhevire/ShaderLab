using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class JuliaController : MonoBehaviour
{
    [Range(-1,1)]
    public float offsetX;
    [Range(-1,1)]
    public float offsetY;
    public float zoom = 3f;

    public Material mat;
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKey(KeyCode.UpArrow))
        {
            offsetY += 0.01f * zoom;
        }
        if (Input.GetKey(KeyCode.DownArrow))
        {
            offsetY -= 0.01f * zoom;
        }
        if (Input.GetKey(KeyCode.LeftArrow))
        {
            offsetX -= 0.01f * zoom;
        }
        if (Input.GetKey(KeyCode.RightArrow))
        {
            offsetX += 0.01f * zoom;
        }
        if (Input.GetKey(KeyCode.PageUp))
        {
            zoom *= .99f;
        }
        if (Input.GetKey(KeyCode.PageDown))
        {
            zoom *= 1.01f;
        }

        mat.SetVector("_Offset", new Vector4(offsetX, offsetY, 0, 0));
        mat.SetFloat("_Zoom", zoom);
    }
}
