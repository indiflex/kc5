import { useTheme } from 'next-themes';
import { useEffect, useState } from 'react';
import { MonitorIcon, MoonIcon, SunIcon } from 'lucide-react';

const themes = ['light', 'system', 'dark'];
const themeIcon = {
  light: <MonitorIcon />,
  system: <MoonIcon />,
  dark: <SunIcon />,
};

export default function ThemeChanger() {
  const { theme, setTheme } = useTheme();
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  const changeTheme = () => {
    let idx = themes.indexOf(theme as keyof typeof themeIcon) + 1;
    if (idx === themes.length) idx = 0;
    setTheme(themes[idx]);
  };

  if (!mounted) {
    return <SunIcon className='w-2 h-2' />;
  }

  return (
    <button
      onClick={changeTheme}
      className='cursor-pointer rounded-full border-1 border-blue-100 hover:ring-1 hover:ring-blue-300 hover:[&>svg]:stroke-blue-300 p-1'
    >
      {themeIcon[theme as keyof typeof themeIcon]}
    </button>
  );
}
