import React, { useState, useEffect } from "react";
import { ColorPicker } from "antd";
import type { ColorPickerProps } from "antd";
import type { Color } from "antd/es/color-picker";
import { green, presetPalettes, red, yellow } from "@ant-design/colors";

type Presets = Required<ColorPickerProps>["presets"][number];
type ColorValue = ColorPickerProps["value"];

type Props = {
  value?: ColorValue;
  onChange?: (value?: string) => void;
  disabled?: boolean;
};

const genPresets = (presets = presetPalettes) =>
  Object.entries(presets).map<Presets>(([label, colors]) => ({
    label,
    colors,
  }));

const ColorInput: React.FC<Props> = ({ value, onChange, disabled = false }) => {
  const [_, setColor] = useState<ColorPickerProps["value"]>("");

  useEffect(() => {
    if (value) setColor(value);
  }, []);

  const triggerChange = (changedValue?: string) => {
    onChange?.(changedValue);
  };

  const onColorChange = (color: Color) => {
    setColor(color.toHexString());
    triggerChange(color.toHexString());
  };

  const presets = genPresets({
    Rojo: red,
    Amarillo: yellow,
    Verde: green,
  });

  return <ColorPicker value={value} onChange={onColorChange} disabledAlpha presets={presets} />;
};

export { ColorInput };
