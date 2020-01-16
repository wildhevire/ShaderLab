using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MandlebrotController : MonoBehaviour
{
    public Material mat;
    public float zoom = 2;
    float offsetX = .5f, offsetY= .5f;

    private void Start()
    {
        //offsetX = Screen.width / 2;
        //offsetY = Screen.height / 2;
    }
    private void Update()
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
        Debug.Log(mat.GetFloat("_Iter"));


    }
}
