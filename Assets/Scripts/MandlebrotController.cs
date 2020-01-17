using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MandlebrotController : MonoBehaviour
{
    public Material mat;
    public float zoom = 2;
    float offsetX = -0.5f, offsetY = 0;
    public InputField inputField;
    public int maxIteration = 1000;

    private void Start()
    {
        inputField.text = "1000";
        //offsetX = Screen.width / 2;
        //offsetY = Screen.height / 2;
    }
    private void Update()
    {
        maxIteration = int.Parse(inputField.text);
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
        mat.SetFloat("_MaxIter", maxIteration);


    }
}
