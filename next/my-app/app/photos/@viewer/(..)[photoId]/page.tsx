type Props = {
  params: { photoId: string };
};

export default function PhotoInterceptor({ params }: Props) {
  const { photoId } = params;

  return <>Interceptor: {photoId}</>;
}
